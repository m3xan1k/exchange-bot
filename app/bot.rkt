#lang racket

(require net/url)
(require json)
(require xml/path)
(require xml)

(define tg-api-token (getenv "TG_API_TOKEN"))
(define tg-base-url 
  (format "https://api.telegram.org/bot~a" tg-api-token))
(define tg-limit 1)
(define tg-timeout 60)

(define cbr-url "http://www.cbr.ru/scripts/XML_daily.asp")


(define (port->jsexpr port)
  (string->jsexpr (port->string port)))


(define (port->xexpr port)
  (xml->xexpr (document-element
                (read-xml port))))


(define (get-updates #:last-update-id (last-update-id null))
  (let ([url (if (null? last-update-id)
                (format "~a/getUpdates?limit=~a&timeout=~a"
                  tg-base-url tg-limit tg-timeout)
                (format "~a/getUpdates?limit=~a&timeout=~a&offset=~a"
                  tg-base-url tg-limit tg-timeout (+ last-update-id 1)))])
    (port->jsexpr (get-pure-port
      (string->url url)))))


(define (get-currencies-xml)
  (port->xexpr
    (get-pure-port (string->url cbr-url))))


(define (make-currency-item code nominal name value)
  (hasheq 'code code 'nominal nominal 'name name 'value value))


(define (parse-xml-to-hashlist doc)
  (let ([codes (se-path*/list '(CharCode) doc)]
        [nominals (se-path*/list '(Nominal) doc)]
        [names (se-path*/list '(Name) doc)]
        [values (se-path*/list '(Value) doc)])
    (map make-currency-item codes nominals names values)))


(define (matched-currency? curr text)
  (string-ci=? (hash-ref curr 'name) text))


(define (create-message text)
  (let* ([doc (get-currencies-xml)]
         [currencies-hashlist (parse-xml-to-hashlist doc)]
         [target-currency (filter matched-currency? currencies-hashlist)])
    target-currency))


(define (listen #:last-update-id (last-update-id null))
  (let ([tg-updates (get-updates #:last-update-id last-update-id)])
    (displayln tg-updates)
    (if (and (hash-ref tg-updates 'ok) (not (null? (hash-ref tg-updates 'result))))
      (let* ([result (first (hash-ref tg-updates 'result))]
             [update-id (hash-ref result 'update_id)]
             [message (if (hash-has-key? result 'message)
                        (hash-ref result 'message)
                        (hash-ref result 'edited_message))]
             [text (hash-ref message 'text)]
             [chat-id (hash-ref (hash-ref message 'chat) 'id)]
             [message-text (create-message text)])
        (displayln message-text)
        (listen #:last-update-id update-id))
      (if (hash-ref tg-updates 'ok)
        (listen)
        null))))


(listen)

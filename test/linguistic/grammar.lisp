
(in-package :weblocks-test)

;;; test pluralize
(deftest pluralize-1
    (pluralize "item")
  "items")

(deftest pluralize-2
    (pluralize "carcass")
  "carcasses")

;;; test singularize
(deftest singularize-1
    (singularize "items")
  "item")

(deftest singularize-2
    (singularize "carcasses")
  "carcass")

(deftest singularize-3
    (singularize "companies")
  "company")

;;; test proper-number-form
(deftest proper-number-form-1
    (proper-number-form 1 "item")
  "item")

(deftest proper-number-form-2
    (proper-number-form 2 "item")
  "items")

(deftest proper-number-form-3
    (proper-number-form 2 "company")
  "companies")

;;; test vowelp
(deftest vowelp-1
    (every #'vowelp '(#\a #\e #\i #\o #\u))
  t)

(deftest vowelp-2
    (notany #'vowelp '(#\b #\c #\d #\f #\g #\h #\j #\k #\l #\m #\n #\p #\q #\r #\s #\t #\v #\w #\x #\y #\z))
  t)

;;; test consonantp
(deftest consonantp-1
    (notany #'consonantp '(#\a #\e #\i #\o #\u))
  t)

(deftest consonantp-2
    (every #'consonantp
           '(#\b #\c #\d #\f #\g #\h #\j #\k #\l #\m #\n #\p #\q #\r #\s #\t #\v #\w #\x #\y #\z))
  t)

;;; test proper-indefinite-article
(deftest proper-indefinite-article-1
    (proper-indefinite-article "item")
  "an")

(deftest proper-indefinite-article-2
    (proper-indefinite-article "thing")
  "a")

(deftest proper-indefinite-article-3
    (proper-indefinite-article "Useable")
  "a")

;;; test articlize
(deftest articlize-1
    (articlize "thing")
  "a thing")

(deftest articlize-2
    (articlize "item")
  "an item")

(defmacro with-russian-translation-function (&body body)
  `(let ((weblocks::*translation-function* 
           (lambda (string &key items-count)
             (case items-count 
               (:one "мир")
               (:few "мира")
               (:many "миров")))))
     ,@body))

(deftest russian-proper-number-form-1
         (with-russian-translation-function 
           (proper-number-form 1 "мир" :ru))
         "мир")
 
(deftest russian-proper-number-form-2
         (with-russian-translation-function 
           (proper-number-form 2 "мир" :ru))
         "мира")

(deftest russian-proper-number-form-3
         (with-russian-translation-function 
           (proper-number-form 5 "мир" :ru))
         "миров")

(defmacro with-russian-translation-function-2 (&body body)
  `(let ((weblocks::*translation-function* 
           (lambda (string &key plural)
             (format nil "pluralized ~A" plural))))
     ,@body))

(deftest russian-pluralize-1
         (with-russian-translation-function-2 
           (pluralize "test" :ru))
         "pluralized T")

(require '[vlaaad.reveal :as r])

(add-tap (r/ui))

(tap> {:vlaaad.reveal/command '(clear-output)})
;; More commands listed at https://vlaaad.github.io/reveal/use#predefined-commands

(require '[portal.api :as p])

(def portal (p/open {:theme :portal.colors/catppuccin, :port 43434}))

(add-tap #'p/submit)

(p/clear)

(prn @portal) ; bring selected value back into repl

(first (p/sessions)) ; Reobtain `p` from Portal's internal state.

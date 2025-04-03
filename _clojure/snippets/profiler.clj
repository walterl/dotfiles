;; https://github.com/clojure-goes-fast/clj-async-profiler#usage
(require '[clj-async-profiler.core :as prof])

;; Profile the following expression:
(prof/profile (dotimes [i 10000] (reduce + (range i))))

;; The resulting flamegraph will be stored in /tmp/clj-async-profiler/results/
;; You can view the HTML file directly from there or start a local web UI:

(prof/serve-ui 8080) ; Serve on port 8080

"Reference snippets for how to start/stop Flow Storm debugger."
(require '[flow-storm.api :as dbg])

(defn start-debugger
  []
  (dbg/local-connect {:theme :dark}))

(defn stop-debugger
  []
  (try
    (dbg/stop)
    (catch Throwable _)))

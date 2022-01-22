{:user {:plugins [[lein-ancient "0.6.15"]
                  [lein-cljfmt "0.7.0"]]
        :local-repo #=(eval (str (System/getenv "XDG_CACHE_HOME") "/m2"))
        :repositories  {"local" {:url #=(eval (str "file://" (System/getenv "XDG_DATA_HOME") "/m2"))
                                 :releases {:checksum :ignore}}}}}

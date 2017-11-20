# re-jump.el
emacs navigation for re-frame projects

## What does it do?
Assuming your re-frame registrations use fully qualified keywords (if they don't, they should) you may have source files that look like this:

```clj
(ns app.model
  (:require [re-frame.core :as re-frame]))
  
(re-frame/reg-event-db
  ::foo
  ...)
```

```clj
(ns app.view
  (:require [re-frame.core :as re-frame]
            [app.model :as model]))
  
(defn bar []
  (re-frame/dispatch [::model/foo]))
```

If you are editing `app.view` you may be interested in what the `foo` event does. Unfortunately CIDER won't let you `jump-to-var` on a keyword because it's not a var! You have to manually visit the `model` namespace amd search for `foo`, possibly skipping past other references to it until you find the declaration where it gets registered.

This becomes a pain when your code gets bigger.

_re-jump_ gives you the same experience jumping to re-frame registrations as CIDER does for vars: with your cursor on a keyword press `M->` (this is `M-.` with the shift key).

Voila!

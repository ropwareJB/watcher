module Model exposing (Model(..))

import Browser.Navigation as Navigation
import Material
import Page.Tree


type Model msg
    = Model
        { browserKey : Navigation.Key
        , mdc : Material.Model msg
        , pageTree : Page.Tree.Model msg

        -- , subscriptions : List ( SubscriptionType, List String, List ( SubscriptionId, SubscriptionValue -> msg ) )
        }

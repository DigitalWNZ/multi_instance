connection: "yostar_0914"

# include all the views
include: "/views/**/*.view"

datagroup: yostar_0914_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: yostar_0914_default_datagroup

explore: users {}

explore: user_plus_daily {}

explore: events {}

### Hello edit

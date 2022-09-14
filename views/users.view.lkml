view: users {
  sql_table_name: `game_cus.users`
    ;;
  drill_fields: [user_id]

  dimension: user_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: first {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year,
      day_of_month,
      day_of_week
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.first_date ;;
  }

  dimension: first_game_version {
    type: string
    sql: ${TABLE}.first_game_version ;;
  }

  dimension: first_platform {
    type: string
    sql: ${TABLE}.first_platform ;;
  }

  measure: count_distince_user_id {
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: count {
    type: count
    drill_fields: [user_id, events.count, user_daily.count, events_raw.count]
  }
}

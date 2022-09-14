view: user_plus_daily {
  derived_table: {
    sql: select a.game_version,a.user_id,a.utc_date,b.first_date,b.first_game_version,b.first_platform,
      date_diff(a.utc_date,b.first_date,day) as retention_day
      from `agolis-allen-first.game_cus.user_daily` a
      join `agolis-allen-first.game_cus.users` b on a.user_id=b.user_id
      where {% condition platform_filter %} first_platform {% endcondition %}
 ;;
  }

  filter: platform_filter {
    type: string
    suggest_dimension: first_platform
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: d1_retained_users_V2 {
    group_label: "Retention"
    description: "Number of players that came back to play on day 1"
    type: count_distinct sql: ${user_id} ;;
    filters: {
      field: retention_day
      value: "1"
    }
  }

  measure: d1_eligible_users_V2 {
    group_label: "Retention"
    description: "Number of players older than 0 days"
    type: count_distinct
    sql: ${user_id} ;;
    filters: {
      field: retention_day
      value: "0"
    }
  }

  measure: d1_retention_rate_V2 {
    group_label: "Retention"
    description: "% of players (that are older than 0 days) that came back to play on day 1"
    value_format_name: percent_2
    type: number
    sql: 1.0 * ${d1_retained_users_V2}/ NULLIF(${d1_eligible_users_V2},0);;
  }

  dimension: game_version {
    type: string
    sql: ${TABLE}.game_version ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: utc_date {
    type: date
    datatype: date
    sql: ${TABLE}.utc_date ;;
  }

  dimension: first_date {
    type: date
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

  dimension: retention_day {
    type: number
    sql: ${TABLE}.retention_day ;;
  }



  set: detail {
    fields: [
      game_version,
      user_id,
      utc_date,
      first_date,
      first_game_version,
      first_platform,
      retention_day
    ]
  }
}

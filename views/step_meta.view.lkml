view: step_meta {
  sql_table_name: `agolis-allen-first.game_cus.step_meta`
    ;;

  dimension: event_name {
    type: string
    sql: ${TABLE}.event_name ;;
  }

  dimension: step {
    type: string
    sql: ${TABLE}.step ;;
  }

  measure: count {
    type: count
    drill_fields: [event_name]
  }
}

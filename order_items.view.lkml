#We will see if this change in gone after I pull from production

##ok lets test this shit

view: order_items {
  sql_table_name: demo_db.order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  measure: count {
    type: count
    drill_fields: [id, inventory_items.id, orders.id]
  }

  measure: revenue1 {
    type: sum
    sql: ${sale_price} ;;
  }

  measure: average_required_price {
    type: average
    sql: ${sale_price} ;;
  }


  measure: profit_for_realz_for_reals {

    type: number
    sql: ${revenue1} - ${inventory_items.total_cost} ;;
  }
}

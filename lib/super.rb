class Super

  def initialize

  end

  module Get_table_names
    db_return = DB.exec("SELECT table_name
                         FROM information_schema.tables
                         WHERE table_schema='public'
                         AND table_type='BASE TABLE';")
    db_array = db_return.map {|i| i.values}.flatten
    class Station < Struct.new(db_array)
    end
  end


end


# look at database and connect class names to table names
# pull column names from tables for accessor variables


# class Point < Struct.new(:x, :y)
#   def distance(point)
#     Math.hypot(point.x - x, point.y - y)
#   end
# end

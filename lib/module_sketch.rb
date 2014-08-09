module Super

  def self.create_classes
    db = self.get_table_names.map{|i| i.capitalize}
    db.each do |table_name|
      const_set(table_name, Class.new(Template))
    end
  end

  class Template
    attr_reader :table, :id

    def initialize(attributes)
      attributes.each_pair {|key, value| self.instance_variable_set(("@"+key), value)}
      attributes.each_key {|key| self.define_singleton_method(key.to_sym) {instance_eval(("@"+key))}}
      @@table = self.class.to_s.gsub(/Super::/, "").downcase
      @attributes = attributes
    end

    def create
      keys = @attributes.keys.join(", ")
      values = @attributes.values.map do|value|
        "'" + value.to_s + "'"
      end
      values = values.join(", ")
      results = DB.exec("INSERT INTO #{@@table} (#{keys}) VALUES (#{values}) RETURNING id;")
      @id = results.first['id'].to_i
    end

    def self.read(attributes)
      items = []
      columns = attributes.keys.join(", ")
      selectors = attributes.values.map {|selector| "'" + selector.to_s + "'"}.join(", ")
      results = DB.exec("SELECT * FROM #{@@table} WHERE (#{columns}) = (#{selectors});")
      results.each do |result|
        items << Template.new(result)
      end
      items
    end

    def self.update(attributes, selector)
      columns = attributes.keys.join(", ")
      selectors = attributes.values.map {|selector| "'" + selector.to_s + "'"}.join(", ")
      DB.exec("UPDATE #{@@table}
      SET (#{columns}) = (#{selectors})
      WHERE #{selector.keys[0]}= #{selector.values[0]};")
    end


  end

  def self.get_table_names
    db_return = DB.exec("SELECT table_name
                         FROM information_schema.tables
                         WHERE table_schema='public'
                         AND table_type='BASE TABLE';")
    db_array = db_return.map {|i| i.values}.flatten
  end
end

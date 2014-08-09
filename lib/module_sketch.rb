module Super

  def self.template
    @name = "bob"
  end

  def self.create_classes

    db = ['Station']

    # template = Object.new.instance_variable_set(:@name, "bob")

    const_set(db[0], Class.new(Template))


    binding.pry
  end


  class Template

    def initialize(attributes)
      attributes.each_pair {|key, value| self.instance_variable_set(("@"+key), value)}
      attributes.each_key {|key| self.define_singleton_method(key.to_sym) {instance_eval(("@"+key))}}
      # self.define_singleton_method(:name) {@name}
    end
  end
  # def get_table_names
  #   # db_return = DB.exec("SELECT table_name
  #   #                      FROM information_schema.tables
  #   #                      WHERE table_schema='public'
  #   #                      AND table_type='BASE TABLE';")
  #   # db_array = db_return.map {|i| i.values}.flatten
  #   @table_name = :Station
  #     Super:: < Struct.new(db_array)
  # end

end



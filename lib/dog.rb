class Dog

    require 'pry'

    attr_accessor :name, :breed
    attr_reader :id

    def initialize(keywords)
        @name = keywords[:name]
        @breed = keywords[:breed]
    end

    def self.create_table
        sql = <<-SQL
        CREATE TABLE IF NOT EXISTS dogs (
            id INTEGER PRIMARY KEY,
            name TEXT,
            breed TEXT
        )
        SQL
        DB[:conn].execute(sql)
    end

    def self.drop_table
        sql = <<-SQL
        DROP TABLE dogs
        SQL
        DB[:conn].execute(sql)
    end

    def save
        sql = <<-SQL
          INSERT INTO dogs (name, breed) VALUES (?, ?)
          SQL
    
        DB[:conn].execute(sql, self.name, self.breed)
        @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
    
        self
      end

      def self.create(attributes)
        dog = self.new(attributes)
        dog.save
        dog
      end

      def self.new_from_db(row)
        attributes = {
            :id => row[0]
            :name => row[1]
            :breed => row[2]
        }
        self.new(attributes)
     end
    


        


end
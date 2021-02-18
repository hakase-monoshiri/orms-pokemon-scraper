class Pokemon

    attr_accessor :name, :type
    attr_reader :id, :db

    def initialize(id: nil, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type) 
            VALUES (?, ?)
        SQL
        db.execute(sql, name, type)
    end

    def self.find(id, database)
        sql = <<-SQL
            SELECT * FROM pokemon
            WHERE id = ?
            LIMIT 1;
        SQL
        found_pokemon = database.execute(sql, id).first
        Pokemon.new(id: found_pokemon[0], name: found_pokemon[1], type: found_pokemon[2], db: database)
    end

end

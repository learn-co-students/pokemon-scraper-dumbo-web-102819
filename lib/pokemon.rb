class Pokemon

    attr_accessor :id, :name, :type, :db

    def initialize(id: nil, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db)
        pokemon = Pokemon.new(name: name, type: type, db: db)
        db.execute(
            "INSERT INTO pokemon (name, type)
            VALUES ( ?, ? )", pokemon.name, pokemon.type
        )
        pokemon.id = db.execute(
            "SELECT last_insert_rowid() FROM pokemon"
        )[0][0]
    end

    def self.find(id, db)
        row = db.execute(
            "SELECT * FROM pokemon
            WHERE id = ?", id
        )[0]
        Pokemon.new(id: row[0], name: row[1], type: row[2], db: db)
    end
end

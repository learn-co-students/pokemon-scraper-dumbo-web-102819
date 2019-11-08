class Pokemon
    attr_accessor :name, :type, :db, :id, :hp

    def initialize(name, type, db, id, hp)
        @name = name
        @type = type
        @db =db
    end

    def self.save(name, type, db)
        db.execute("insert into pokemon (name, type) VALUES (?, ?)", name, type)
    end

    #This method uses array indexes to access various parts of the table 
    def self.find(num, db)
        db.execute("SELECT * FROM pokemon WHERE id=?", [num])
        new_pokemon = self.new(pokemon)
        new_pokemon.id = pokemon[0][0]
        new_pokemon.name = pokemon [0][1]
        new_pokemon.type = pokemon [0][2]
        new_pokemon.hp = pokemon [0][3]
        return new_pokemon
    end
end

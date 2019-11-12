class Pokemon
    attr_accessor :id, :name, :type, :db
    def initialize(id:, name:, type:, hp: nil, db:)
        @name = name
        @type = type
        @id = id
        @db = db 
    end 
    def self.save(name, type, db)
        save_me = <<-save_me
        INSERT INTO pokemon (name, type)
        VALUES (?, ?)
        save_me
        db.execute(save_me, [name, type])
    end 
    def update 
        update_me <<-update_me
        UPDATE pokemons
        SET name = ?, type =?, id = ?
        WHERE id = ?
        update_me
        DB[:conn].execute(update_me, self.name, self.type, self.id, self.id)
    end 
    def self.create_table
        create_t <<-create_t
        CREATE TABLE pokemons (
            id INTEGER PRIMARY KEY,
            name TEXT,
            type TEXT
        )
        create_t
        DB[:conn].execute(create_t)
    end 
    def self.create(name, type)
        pokemon_instance = Pokemon.new(name, type)
        pokemon_instance.save
        pokemon_instance
    end 
    def self.new_from_db(row)
        Pokemon.new(row[1], row[2], row[0])
    end
    def self.find(id_num, db)
        
        temp_yay = db.execute("SELECT * FROM pokemon WHERE id = ?", id_num).flatten
        Pokemon.new(id: temp_yay[0], name: temp_yay[1], type: temp_yay[2], db: db)
    end 
end

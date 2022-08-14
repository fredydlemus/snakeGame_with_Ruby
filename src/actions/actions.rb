module Actions
    def self.move_snake(state)
        
        if next_position = calc_next_position(state)
        # verify if the next direction is valid
        if position_is_valid?(state, next_position)
            move_snake_to(state, next_position)
        else
            end_game(state)
        end

    end

    private 

    def calc_next_position(state)
        current_position = state.snake.positions.first
        case state.next_direction
        when UP
            #decrease row
            
            return current_position = Model::Coord.new(current_position.row - 1, current_position.col)
            
        when DOWN
            return current_position = Model::Coord.new(current_position.row + 1, current_position.col)
        when LEFT
            #decrease col
            return current_position = Model::Coord.new(current_position.row, current_position.col - 1)
        when RIGHT
            return current_position = Model::Coord.new(current_position.row, current_position.col + 1)
        end
    end

    def position_is_valid?(state, position)
        # verify if is in the grid
        is_invalid = ((position.row >= state.grid.rows || position.row < 0) || (position.col >= state.grid.cols || position.col < 0))
        return false if is_invalid

        return !(state.snake.positions.include?(position))
        #verify if is not in the snake
    end

    def move_snake_to(state, next_position)
        new_positions = [next_position] + state.snake.positions[0...-1]
        state.snake.positions = new_positions
        state
    end

    def end_game(state)
        state.game_finished = true
        state
    end

end
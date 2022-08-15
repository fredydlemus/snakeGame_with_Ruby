module Actions
    def self.move_snake(state)
        next_direction = state.curr_direction
        if next_position = calc_next_position(state)
        end
        # verify if the next direction is valid
        if position_is_food?(state, next_position)
            grow_snake_to(state, next_position)
        elsif position_is_valid?(state, next_position)
            move_snake_to(state, next_position)
        else
            end_game(state)
        end

    end

    def self.change_direction(state, direction)
        if next_direction_is_valid?(state, direction)
            state.curr_direction = direction
        else
            puts "Invalid direction"
        end
        state
    end

    private 

    def self.position_is_food?(state, next_position)
        state.food.row == next_position.row &&  state.food.col == next_position.col
    end

    def self.grow_snake_to(state, next_position)

        new_snake = [next_position] + state.snake.positions
        state.snake.positions = new_snake
        state
    end

    def self.calc_next_position(state)
        current_position = state.snake.positions.first
        case state.curr_direction
        when :UP
            #decrease row
            
            return current_position = Model::Coord.new(current_position.row - 1, current_position.col)
            
        when :DOWN
            return current_position = Model::Coord.new(current_position.row + 1, current_position.col)
        when :LEFT
            #decrease col
            return current_position = Model::Coord.new(current_position.row, current_position.col - 1)
        when :RIGHT
            return current_position = Model::Coord.new(current_position.row, current_position.col + 1)
        end
    end

    def self.position_is_valid?(state, position)
        # verify if is in the grid
        is_invalid = ((position.row >= state.grid.rows || position.row < 0) || (position.col >= state.grid.cols || position.col < 0))
        return false if is_invalid

        return !(state.snake.positions.include?(position))
        #verify if is not in the snake
    end

    def self.move_snake_to(state, next_position)
        new_positions = [next_position] + state.snake.positions[0...-1]
        state.snake.positions = new_positions
        state
    end

    def self.end_game(state)
        state.game_finished = true
        state
    end

    def self.next_direction_is_valid?(state, direction)
        case state.curr_direction
        when Model::Direction::UP
            return true if direction != Model::Direction::DOWN
        when Model::Direction::DOWN
            return true if direction != Model::Direction::UP
        when Model::Direction::LEFT
            return true if direction != Model::Direction::RIGHT
        when Model::Direction::RIGHT
            return true if direction != Model::Direction::LEFT
        end
        return false
    end

end
require "ruby2d"
require_relative "../model/state"

module View
    class Ruby2DView
        def initialize(app)
            @pixel_size = 50
            @app = app
        end

        def start(state)
            #extend is for adding methods to the class but not to their instances
            extend Ruby2D::DSL
            set(
                title: "Snake", 
                width: @pixel_size * state.grid.cols, 
                height: @pixel_size * state.grid.rows)
            on :key_down do |event|
                handle_key_event(event)
                
            end
            show
        end

        def renderGame(state)
            render_snake(state)
            render_food(state)
            
        end

        private

      

        def render_food(state)
            @food.remove if @food
            extend Ruby2D::DSL
            food = state.food
            @food = Square.new(
                x: food.col * @pixel_size,
                y: food.row * @pixel_size,
                size: @pixel_size,
                color: "yellow",
            )
        end

        def render_snake(state)
            @snake_positions.each(&:remove) if @snake_positions
            extend Ruby2D::DSL
            snake = state.snake
            @snake_positions = snake.positions.map do |pos|
                Square.new(
                    x: pos.col * @pixel_size,
                    y: pos.row * @pixel_size,
                    size: @pixel_size,
                    color: "green",
                )
            end
        end

        def handle_key_event(event)
            case event.key
            when "up"
                #puts "up"
                @app.send_action(:change_direction, Model::Direction::UP)
            when "down"
                #puts "down"
                @app.send_action(:change_direction, Model::Direction::DOWN)
            when "left"
                #puts "left"
                @app.send_action(:change_direction, Model::Direction::LEFT)
            when "right"
                #puts "right"
                @app.send_action(:change_direction, Model::Direction::RIGHT)
            end
        end
    end
end
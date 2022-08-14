require "ruby2d"

module View
    class Ruby2DView
        def initialize
            @pixel_size = 50
        end

        def start(state)
            #extend is for adding methods to the class but not to their instances
            extend Ruby2D::DSL
            set(
                title: "Snake", 
                width: @pixel_size * state.grid.cols, 
                height: @pixel_size * state.grid.rows)
            show
        end

        def renderGame(state)
            render_snake(state)
            render_food(state)
            
        end

        private

        def render_food(state)
            extend Ruby2D::DSL
            food = state.food
            Square.new(
                x: food.col * @pixel_size,
                y: food.row * @pixel_size,
                size: @pixel_size,
                color: "yellow",
            )
        end

        def render_snake(state)
            extend Ruby2D::DSL
            snake = state.snake
            snake.positions.each do |pos|
                Square.new(
                    x: pos.col * @pixel_size,
                    y: pos.row * @pixel_size,
                    size: @pixel_size,
                    color: "green",
                )
            end
        end
    end
end
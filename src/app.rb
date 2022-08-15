require_relative "view/ruby2d"
require_relative "model/state"
require_relative "actions/actions"



class App
    def initialize
        @state = Model::initial_state
    end

    def start
        puts "Starting app"
        @view = View::Ruby2DView.new(self)
        Thread.new { init_timer(@view) }
        @view.start(@state)
        
    end

    def init_timer(view)
        loop do
            
            @state = Actions::move_snake(@state)
            view.renderGame(@state)
            sleep 0.5
            # trigger movement
        end
    end

    def send_action(action, params)
        #This is meta programming
        new_state = Actions.send(action, @state, params)
        #a hash is calculated in base of the data in the state
        if new_state.hash != @state.hash
            @state = new_state
            @view.render(@state)
        end
    end
    
end

app = App.new
app.start
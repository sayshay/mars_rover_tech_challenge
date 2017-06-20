require 'test/unit'

class Rover
    @@cardinal_directions = ["N", "E", "S", "W"]

    def initialize(x, y, direction)
        @x, @y = x, y
        @direction = direction
    end

    def move
        case @direction
        when 'N'
            @y += 1
        when 'E'
            @x += 1
        when 'S'
            @y -= 1
        when 'W'
            @x -= 1
        end
    end

    def turn(direction)
        if direction == 'left'
            index = @@cardinal_directions.index(@direction ) - 1
        elsif direction == 'right'
            index = @@cardinal_directions.index(@direction ) - 3
        end
        @direction = @@cardinal_directions[index]
    end

    def output_position
        return "#{@x} #{@y} #{@direction}"
    end
end



class Controller
    def initialize(width, height, rover)
        @width, @height = width, height
        @rover = rover
    end

    def perform_action(action)
        case action
        when 'M'
            @rover.move
        when 'L'
            @rover.turn 'left'
        when 'R'
            @rover.turn 'right'
        end
    end

    def moving_instructions(instructions)
        instructions.split('').each do |action|
            self.perform_action(action)
        end
    end
end




class TestRover < Test::Unit::TestCase
    def test_1_output_position
        rover = Rover.new(1, 2, 'N')
        controller = Controller.new(5, 5, rover)
        controller.moving_instructions("LMLMLMLMM")
        expected = rover.output_position
        assert_equal expected, "1 3 N"
    end

    def test_2_output_position
        rover = Rover.new(3, 3, 'E')
        controller = Controller.new(5, 5, rover)
        controller.moving_instructions("MMRMMRMRRM")
        expected = rover.output_position
        assert_equal expected, "5 1 E"
    end

    def test_3_output_position
        rover = Rover.new(0, 0, 'E')
        controller = Controller.new(5, 5, rover)
        controller.moving_instructions("MMLMMRMMLMMLMMRMMR")
        expected = rover.output_position
        assert_equal expected, "2 6 E"
    end
end

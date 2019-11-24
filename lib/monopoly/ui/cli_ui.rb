module Monopoly
  module Ui
    class CliUi
      def run
        game_intro
        new_game
        loop do
          print_state
          input = ask_command
          break unless process_input(input)
        end
      end

      def ask_command
        print 'Command ([r]oll, [n]ew, [q]uit): '
        gets.chomp
      end

      def process_input(input)
        case input
        when 'roll', 'r', ''
          roll

        when 'new', 'n'
          new_game

        when 'quit', 'q'
          puts 'quitting...'
          return false

        else
          puts "unknown command '#{input}'"
        end

        true
      end

      def roll
        roll = @playable.roll

        puts
        puts "#{@playable.current_player.name}'s turn, rolled #{roll}"
        puts
      end

      def game_intro
        puts
        puts 'MONOPOLY DISPLAY INSTRUCTIONS'
        puts
        puts 'Properties:'
        puts '  P means there\'s a property'
        puts '  G means it\'s a Go tile'
        puts '  _ means it\'s a empty tile'
        puts '  PN means it\'s a property with a owner, N is the owner\'s player number'
      end

      def new_game
        loop do
          print 'how many players? (2-4, [c]ancel): '
          input = gets.chomp

          if ['cancel', 'c'].include?(input)
            puts 'cancelling new game'
            @playable.nil? ? exit : return
          end

          input = input.to_i

          unless input.between?(2, 4)
            puts 'invalid number of players'
            next
          end

          puts
          puts "starting new game for #{input} players..."
          puts

          board = Monopoly::Builders::BoardBuilder.build do |builder|
            builder.add_tiles(Monopoly::Tiles::PropertyTile, number: 28, cost: 100)
            builder.add_tiles(Monopoly::Tiles::GoTile, number: 4)
            builder.add_tiles(Monopoly::Tiles::EmptyTile, number: 8)
          end

          @playable = Monopoly::Builders::MatchBuilder.build do |builder|
            1.upto(input) { |i| builder.add_player(Monopoly::Player.new(i)) }
            builder.add_dice(Monopoly::Dice.new)
            builder.add_dice(Monopoly::Dice.new)
            builder.set_board(board)
          end

          return
        end
      end

      def print_state
        print_board
        print_players
      end

      def print_players
        @playable.players.each do |player|
          puts player.name
          puts " balance: #{player.balance}"
          puts " position: #{player.position}"
          puts " properties: #{player.properties.size}"
        end
      end

      def print_board
        print 'Properties: '
        @playable.board.tiles.each { |tile| print tile.name }

        puts
        print ' Positions: '
        0.upto(@playable.board.tiles.size - 1) { |i| i < 10 ? print("#{i}  ") : print("#{i} ") }
        2.times { puts }
      end
    end
  end
end

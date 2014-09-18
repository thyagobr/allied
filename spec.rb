require './main.rb'

describe Player do
  before { @player = Player.new }
  context "when newly created" do
    it "has four groups in his army" do
      expect(@player.army.size).to be 4
    end
  end
end

describe Main do
  before { @main = Main.new }
  context "game loop" do
    expect(
  end
end

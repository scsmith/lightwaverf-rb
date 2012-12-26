describe LightwaveRF do
  describe ".new" do
    it "should assign @prefix" do
      LightwaveRF.new.prefix.should_not be_nil
      LightwaveRF.new.prefix.should match(/\d{3}/)
    end
  end

  describe "protected methods" do
    describe "#generate_prefix" do
      it "should create string of length 3" do
        prefix = LightwaveRF.new.send(:generate_prefix)
        prefix.class.name.should == "String"
        prefix.length.should == 3
        prefix.should match(/0\d{2}/)
      end
    end

    describe "#generate_command" do
      it "should correctly format a command using the default prefix" do
        lightwave = LightwaveRF.new
        prefix = lightwave.prefix
        lightwave.send(:generate_command, 1, 1, "F0").should == "#{prefix},!R1D1F0|"
      end
    end

    describe "#generate_and_send_command" do
      it "should call generate_command with the given arguments then call send_command" do
        lightwave = LightwaveRF.new
        prefix = lightwave.prefix
        lightwave.should_receive("generate_command").with(1, 1, "F0", prefix)
        lightwave.should_receive("send_command").and_return(true)
        lightwave.send(:generate_and_send_command, 1, 1, "F0")
      end

      it "should call send_command with the given arguments" do
        lightwave = LightwaveRF.new
        prefix = lightwave.prefix
        lightwave.should_receive("generate_command").and_return("command_name")
        lightwave.should_receive("send_command").with("command_name")
        lightwave.send(:generate_and_send_command, 1, 1, "F0")
      end
    end

    describe "#level" do
      it "should return 1 for 0%" do
        LightwaveRF.new.send(:level, 0).should == 1
      end

      it "should return 16 for 50%" do
        LightwaveRF.new.send(:level, 50).should == 16
      end

      it "should return 32 for 100%" do
        LightwaveRF.new.send(:level, 100).should == 32
      end
    end
  end

  describe "register" do
    it "should send '533,!R1D1F0|'" do
      lightwave = LightwaveRF.new
      lightwave.should_receive("send_command").with("533,!R1D1F0|")
      lightwave.register
    end
  end

  describe "#turn_on" do
    it "should send '001,!R1D1F1|' for room 1 device 1" do
      lightwave = LightwaveRF.new
      lightwave.prefix = "001"
      lightwave.should_receive("send_command").with("001,!R1D1F1|")
      lightwave.turn_on(1, 1)
    end

    it "should send '001,!R3D4F1|' for room 3 device 4" do
      lightwave = LightwaveRF.new
      lightwave.prefix = "001"
      lightwave.should_receive("send_command").with("001,!R3D4F1|")
      lightwave.turn_on(3, 4)
    end
  end

  describe "#turn_off" do
    it "should send '001,!R1D1F0|' for room 1 device 1" do
      lightwave = LightwaveRF.new
      lightwave.prefix = "001"
      lightwave.should_receive("send_command").with("001,!R1D1F0|")
      lightwave.turn_off(1, 1)
    end

    it "should send '001,!R3D4F0|' for room 3 device 4" do
      lightwave = LightwaveRF.new
      lightwave.prefix = "001"
      lightwave.should_receive("send_command").with("001,!R3D4F0|")
      lightwave.turn_off(3, 4)
    end
  end

  describe "#dim" do
    it "should send  001,!R1D1FdP32 for 0% brightness" do
      lightwave = LightwaveRF.new
      lightwave.prefix = "001"
      lightwave.should_receive("send_command").with("001,!R1D1FdP1|")
      lightwave.dim(1, 1, 0)
    end

    it "should send  001,!R1D1FdP6 for 20% brightness" do
      lightwave = LightwaveRF.new
      lightwave.prefix = "001"
      lightwave.should_receive("send_command").with("001,!R1D1FdP7|")
      lightwave.dim(1, 1, 20)
    end

    it "should send  001,!R1D1FdP32 for 50% brightness" do
      lightwave = LightwaveRF.new
      lightwave.prefix = "001"
      lightwave.should_receive("send_command").with("001,!R1D1FdP16|")
      lightwave.dim(1, 1, 50)
    end

    it "should send  001,!R1D1FdP32 for 100% brightness" do
      lightwave = LightwaveRF.new
      lightwave.prefix = "001"
      lightwave.should_receive("send_command").with("001,!R1D1FdP32|")
      lightwave.dim(1, 1, 100)
    end
  end
end
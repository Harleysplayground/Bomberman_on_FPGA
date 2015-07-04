library verilog;
use verilog.vl_types.all;
entity bob is
    generic(
        restore_time    : vl_logic_vector(9 downto 0) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0);
        flame_time      : vl_logic_vector(9 downto 0);
        bomb_cycle      : vl_logic_vector(9 downto 0)
    );
    port(
        Reset           : in     vl_logic;
        frame_clk       : in     vl_logic;
        command         : in     vl_logic_vector(2 downto 0);
        mapX            : in     vl_logic_vector(3 downto 0);
        mapY            : in     vl_logic_vector(3 downto 0);
        state           : out    vl_logic_vector(2 downto 0);
        outx            : out    vl_logic_vector(3 downto 0);
        outy            : out    vl_logic_vector(3 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of restore_time : constant is 2;
    attribute mti_svvh_generic_type of flame_time : constant is 4;
    attribute mti_svvh_generic_type of bomb_cycle : constant is 4;
end bob;

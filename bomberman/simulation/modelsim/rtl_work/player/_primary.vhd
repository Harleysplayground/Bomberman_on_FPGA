library verilog;
use verilog.vl_types.all;
entity player is
    generic(
        player_X_pos_init: vl_logic_vector(9 downto 0) := (Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        player_Y_pos_init: vl_logic_vector(9 downto 0) := (Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0);
        bomb_count_init : vl_logic_vector(3 downto 0) := (Hi0, Hi0, Hi0, Hi1);
        bomb_power_init : vl_logic_vector(3 downto 0) := (Hi0, Hi0, Hi0, Hi1);
        width           : vl_logic_vector(9 downto 0) := (Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        height          : vl_logic_vector(9 downto 0) := (Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0)
    );
    port(
        Reset           : in     vl_logic;
        frame_clk       : in     vl_logic;
        command         : in     vl_logic_vector(2 downto 0);
        enabled         : in     vl_logic;
        xSpeed          : in     vl_logic_vector(4 downto 0);
        ySpeed          : in     vl_logic_vector(4 downto 0);
        playerX         : out    vl_logic_vector(9 downto 0);
        playerY         : out    vl_logic_vector(9 downto 0);
        state           : out    vl_logic_vector(2 downto 0);
        outx            : out    vl_logic_vector(3 downto 0);
        outy            : out    vl_logic_vector(3 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of player_X_pos_init : constant is 2;
    attribute mti_svvh_generic_type of player_Y_pos_init : constant is 2;
    attribute mti_svvh_generic_type of bomb_count_init : constant is 2;
    attribute mti_svvh_generic_type of bomb_power_init : constant is 2;
    attribute mti_svvh_generic_type of width : constant is 2;
    attribute mti_svvh_generic_type of height : constant is 2;
end player;

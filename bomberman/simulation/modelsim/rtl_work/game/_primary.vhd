library verilog;
use verilog.vl_types.all;
entity game is
    generic(
        xSpeed          : vl_logic_vector(0 to 4) := (Hi0, Hi0, Hi1, Hi0, Hi0);
        ySpeed          : vl_logic_vector(0 to 4) := (Hi0, Hi0, Hi0, Hi1, Hi1);
        SPACE           : vl_logic_vector(7 downto 0) := (Hi0, Hi0, Hi1, Hi0, Hi1, Hi1, Hi0, Hi0);
        A_UP            : vl_logic_vector(7 downto 0) := (Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi0);
        A_DOWN          : vl_logic_vector(7 downto 0) := (Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi1);
        A_LEFT          : vl_logic_vector(7 downto 0) := (Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0);
        A_RIGHT         : vl_logic_vector(7 downto 0) := (Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1);
        width           : vl_logic_vector(9 downto 0) := (Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        height          : vl_logic_vector(9 downto 0) := (Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0)
    );
    port(
        Reset           : in     vl_logic;
        frame_clk       : in     vl_logic;
        keycode         : in     vl_logic_vector(7 downto 0);
        map_1d          : out    vl_logic_vector(299 downto 0);
        playerX         : out    vl_logic_vector(9 downto 0);
        playerY         : out    vl_logic_vector(9 downto 0);
        over            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of xSpeed : constant is 1;
    attribute mti_svvh_generic_type of ySpeed : constant is 1;
    attribute mti_svvh_generic_type of SPACE : constant is 2;
    attribute mti_svvh_generic_type of A_UP : constant is 2;
    attribute mti_svvh_generic_type of A_DOWN : constant is 2;
    attribute mti_svvh_generic_type of A_LEFT : constant is 2;
    attribute mti_svvh_generic_type of A_RIGHT : constant is 2;
    attribute mti_svvh_generic_type of width : constant is 2;
    attribute mti_svvh_generic_type of height : constant is 2;
end game;

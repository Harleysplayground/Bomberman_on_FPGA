library verilog;
use verilog.vl_types.all;
entity game_bench is
    generic(
        SPACE           : vl_logic_vector(7 downto 0) := (Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi0, Hi0);
        A_UP            : vl_logic_vector(7 downto 0) := (Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi0);
        A_DOWN          : vl_logic_vector(7 downto 0) := (Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi1);
        A_LEFT          : vl_logic_vector(7 downto 0) := (Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0);
        A_RIGHT         : vl_logic_vector(7 downto 0) := (Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of SPACE : constant is 2;
    attribute mti_svvh_generic_type of A_UP : constant is 2;
    attribute mti_svvh_generic_type of A_DOWN : constant is 2;
    attribute mti_svvh_generic_type of A_LEFT : constant is 2;
    attribute mti_svvh_generic_type of A_RIGHT : constant is 2;
end game_bench;

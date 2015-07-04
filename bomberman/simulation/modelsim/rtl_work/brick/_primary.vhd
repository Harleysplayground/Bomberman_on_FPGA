library verilog;
use verilog.vl_types.all;
entity brick is
    port(
        addr            : in     vl_logic_vector(11 downto 0);
        BRICK_RED       : out    vl_logic_vector(7 downto 0);
        BRICK_GREEN     : out    vl_logic_vector(7 downto 0);
        BRICK_BLUE      : out    vl_logic_vector(7 downto 0)
    );
end brick;

library verilog;
use verilog.vl_types.all;
entity font_rom is
    port(
        addr            : in     vl_logic_vector(11 downto 0);
        ROM_RED         : out    vl_logic_vector(7 downto 0);
        ROM_GREEN       : out    vl_logic_vector(7 downto 0);
        ROM_BLUE        : out    vl_logic_vector(7 downto 0)
    );
end font_rom;

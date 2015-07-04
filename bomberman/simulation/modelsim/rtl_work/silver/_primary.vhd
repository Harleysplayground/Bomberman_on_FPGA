library verilog;
use verilog.vl_types.all;
entity silver is
    port(
        addr            : in     vl_logic_vector(11 downto 0);
        SILVER_RED      : out    vl_logic_vector(7 downto 0);
        SILVER_GREEN    : out    vl_logic_vector(7 downto 0);
        SILVER_BLUE     : out    vl_logic_vector(7 downto 0)
    );
end silver;

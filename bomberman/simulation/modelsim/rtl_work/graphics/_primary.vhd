library verilog;
use verilog.vl_types.all;
entity graphics is
    port(
        PlayerXp1       : in     vl_logic_vector(9 downto 0);
        PlayerYp1       : in     vl_logic_vector(9 downto 0);
        DrawX           : in     vl_logic_vector(9 downto 0);
        DrawY           : in     vl_logic_vector(9 downto 0);
        Red             : out    vl_logic_vector(7 downto 0);
        Green           : out    vl_logic_vector(7 downto 0);
        Blue            : out    vl_logic_vector(7 downto 0);
        DistXs          : out    vl_logic_vector(9 downto 0);
        DistYs          : out    vl_logic_vector(9 downto 0);
        mapx            : out    vl_logic_vector(3 downto 0);
        mapy            : out    vl_logic_vector(3 downto 0)
    );
end graphics;

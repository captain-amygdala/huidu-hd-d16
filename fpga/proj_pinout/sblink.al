<?xml version="1.0" encoding="UTF-8"?>
<Project Version="1" Path="H:/huidu_d16/rtl">
    <Project_Created_Time></Project_Created_Time>
    <TD_Version>5.0.30786</TD_Version>
    <UCode>00000000</UCode>
    <Name>sblink</Name>
    <HardWare>
        <Family>EG4</Family>
        <Device>EG4A20BG256</Device>
    </HardWare>
    <Source_Files>
        <Verilog>
            <File Path="blink.v">
                <FileInfo>
                    <Attr Name="UsedInSyn" Val="true"/>
                    <Attr Name="UsedInP&R" Val="true"/>
                    <Attr Name="BelongTo" Val="design_1"/>
                    <Attr Name="CompileOrder" Val="1"/>
                </FileInfo>
            </File>
            <File Path="al_ip/ghfh.v">
                <FileInfo>
                    <Attr Name="UsedInSyn" Val="true"/>
                    <Attr Name="UsedInP&R" Val="true"/>
                    <Attr Name="BelongTo" Val="design_1"/>
                    <Attr Name="CompileOrder" Val="2"/>
                </FileInfo>
            </File>
            <File Path="uart.v">
                <FileInfo>
                    <Attr Name="UsedInSyn" Val="true"/>
                    <Attr Name="UsedInP&R" Val="true"/>
                    <Attr Name="BelongTo" Val="design_1"/>
                    <Attr Name="CompileOrder" Val="3"/>
                </FileInfo>
            </File>
        </Verilog>
        <ADC_FILE>
            <File Path="test2.adc">
                <FileInfo>
                    <Attr Name="UsedInSyn" Val="true"/>
                    <Attr Name="UsedInP&R" Val="true"/>
                    <Attr Name="BelongTo" Val="constrain_1"/>
                    <Attr Name="CompileOrder" Val="1"/>
                </FileInfo>
            </File>
        </ADC_FILE>
    </Source_Files>
    <FileSets>
        <FileSet Name="constrain_1" Type="ConstrainFiles">
        </FileSet>
        <FileSet Name="design_1" Type="DesignFiles">
        </FileSet>
    </FileSets>
    <TOP_MODULE>
        <LABEL>blink</LABEL>
        <MODULE>blink</MODULE>
        <CREATEINDEX></CREATEINDEX>
    </TOP_MODULE>
    <Property>
        <BitgenProperty::GeneralOption>
            <bin>on</bin>
            <header>6C030246ABEF0900FFFFFFFFFFFFFFFF</header>
            <s>off</s>
        </BitgenProperty::GeneralOption>
    </Property>
    <Device_Settings>
        <EG4A20BG256>
            <tdi_tms_tck_tdo>gpio</tdi_tms_tck_tdo>
        </EG4A20BG256>
    </Device_Settings>
    <Configurations>
    </Configurations>
    <Project_Settings>
        <Step_Last_Change>2022-04-28 17:44:47.160</Step_Last_Change>
        <Current_Step>60</Current_Step>
        <Step_Status>true</Step_Status>
    </Project_Settings>
</Project>

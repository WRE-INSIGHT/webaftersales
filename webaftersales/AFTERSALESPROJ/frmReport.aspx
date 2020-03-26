<%@ Page Title="" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" Language="C#" AutoEventWireup="true" CodeBehind="frmReport.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.frmReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="css/CSSreporting.css" rel="stylesheet" />
    <link href="css/gridcss.css" rel="stylesheet" />
    <style type="text/css">
        .Background {
            background-color: Black;
            filter: alpha(opacity=90);
            opacity: 0.8;
        }

        .Popup {
            border-radius: 5px;
            background-color: #f2f2f2;
            padding: 20px;
            /*background-color: #FFFFFF;*/
            border-width: 3px;
            border-style: solid;
            border-color: black;
            /*padding-top: 10px;
            padding-left: 10px;*/
            width: 500px;
            height: 500px;
        }

        .lbl {
            font-size: 16px;
            font-style: italic;
            font-weight: bold;
        }
    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div>
        <asp:Label ID="lblproject" runat="server" Text="Sample Project Name" Font-Bold="True" Font-Names="Calibri" Font-Size="25pt" ForeColor="#FF3399"></asp:Label>
        <br />
        <asp:Label ID="lbladdress" runat="server" Text="Address" Font-Names="Century Gothic" Font-Size="11pt" Font-Strikeout="False" ForeColor="#CC00CC"></asp:Label>
        <br />
        <br />
        <asp:Label ID="lblprofilefinish" runat="server" Text="Profile finish" Font-Names="Calibri" Font-Size="12pt" Font-Strikeout="False" ForeColor="#666699"></asp:Label>
        <asp:Label ID="lbljo" runat="server" Text="Job Order No." Font-Names="Segoe UI" Font-Size="15pt" Font-Strikeout="False" ForeColor="#666699"></asp:Label>

        <br />
    </div>
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" runat="server"
            CancelControlID="btncancel" TargetControlID="btnaddnewreport" PopupControlID="pnl1"
            BackgroundCssClass="Background">
        </ajaxToolkit:ModalPopupExtender>
        <asp:Panel runat="server" ID="pnl1" CssClass="form-style-8" align="center" Style="display: none">
            <div>
                <asp:Button ID="btncancel" runat="server" CssClass="btncancel" Text="X" />
            </div>
            <table style="width: 500px">
                <tr>
                    <td>
                        <asp:Label ID="Label8" runat="server" Text="Item#"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox CssClass="tboxinput" ID="tboxitemno" runat="server"></asp:TextBox>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label9" runat="server" Text="K#"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox CssClass="tboxinput" ID="tboxkno" runat="server"></asp:TextBox>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label10" runat="server" Text="Location"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox CssClass="tboxinput" ID="tboxlocation" runat="server"></asp:TextBox>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label11" runat="server" Text="Specification"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="dlistspecification" CssClass="tboxinput" runat="server">
                            <asp:ListItem>-</asp:ListItem>
                            <asp:ListItem>Window</asp:ListItem>
                            <asp:ListItem>Door</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="dlistspecification" ValidationGroup="validationpopup"
                            ErrorMessage="specification is required" Text="*" ForeColor="Red" InitialValue="-"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label12" runat="server" Text="Mobilization Cost"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox CssClass="tboxinput" ID="tboxmobilizationcost" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="invalid amount" Text="*"
                            ControlToValidate="tboxmobilizationcost" Type="Double" Operator="DataTypeCheck" ValidationGroup="validationpopup"
                            ForeColor="Red"></asp:CompareValidator>
                    </td>
                </tr>
            </table>
            <div>
                <asp:Button ID="Button1" ValidationGroup="validationpopup" CssClass="btn" Width="200" runat="server" Text="add" OnClick="addbtn_Click" />
            </div>
            <asp:ValidationSummary ID="validationpopup" ForeColor="Red" ValidationGroup="validationpopup" runat="server" />
        </asp:Panel>
        <br />
        <asp:Button ID="btnaddnewreport" CssClass="btnsubmit" runat="server" Text="Add New Item" Width="186px" />
        <br />
        <br />
        <asp:Button ID="btnimportitem" runat="server" OnClick="btnimportitem_Click" Text="import items" />
        <br />
    </div>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>

            <br />
            <asp:Label ID="lblerror" runat="server"></asp:Label>
            <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSource1"
                EmptyDataText="NO RESULT" EnablePersistedSelection="True"
                OnRowUpdated="GridView2_RowUpdated" ShowFooter="True" OnPageIndexChanging="GridView2_PageIndexChanging"
                PageSize="5" OnRowDataBound="GridView2_RowDataBound" OnDataBound="GridView2_DataBound"
                OnRowCancelingEdit="GridView2_RowCancelingEdit" Font-Names="Segoe UI" Font-Size="12px" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical">
                <AlternatingRowStyle BackColor="#DCDCDC" />
                <Columns>
                    <asp:CommandField ShowDeleteButton="true"
                        ControlStyle-CssClass="actionbtn"
                        EditImageUrl="~/AFTERSALESPROJ/images/edit.png"
                        DeleteImageUrl="~/AFTERSALESPROJ/images/delete.png"
                        CancelImageUrl="~/AFTERSALESPROJ/images/cancel.png"
                        UpdateImageUrl="~/AFTERSALESPROJ/images/save.png"
                        ShowEditButton="true">
                        <ControlStyle CssClass="actionbtn"></ControlStyle>
                    </asp:CommandField>
                    <asp:TemplateField HeaderText="" SortExpression="ID">
                        <EditItemTemplate>
                            <asp:Label ID="Label1" Visible="false" runat="server" Text='<%# Eval("ID") %>'></asp:Label>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label6" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="" SortExpression="SID">
                        <EditItemTemplate>
                            <asp:Label ID="Label7" Visible="false" runat="server" Text='<%# Bind("SID") %>'></asp:Label>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label7" Visible="false" runat="server" Text='<%# Bind("SID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ITEMNO" SortExpression="ITEMNO">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" CssClass="tboxinput" Width="50px" runat="server" Text='<%# Bind("ITEMNO") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("ITEMNO") %>'></asp:Label>
                        </ItemTemplate>

                        <FooterTemplate>
                            <asp:TextBox ID="tboxitemno" Width="50px" CssClass="tboxinput" runat="server"></asp:TextBox>
                        </FooterTemplate>

                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="KNO" SortExpression="KNO">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" Width="70px" CssClass="tboxinput" runat="server" Text='<%# Bind("KNO") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("KNO") %>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="tboxkno" Width="70px" CssClass="tboxinput" runat="server"></asp:TextBox>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="LOCATION" SortExpression="LOCATION">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" Width="100px" CssClass="tboxinput" runat="server" Text='<%# Bind("LOCATION") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("LOCATION") %>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="tboxlocation" Width="100px" CssClass="tboxinput" runat="server"></asp:TextBox>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="SPECIFICATION" SortExpression="SPECIFICATION">
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownList1" CssClass="tboxinput" SelectedValue='<%# Bind("SPECIFICATION") %>' runat="server">
                                <asp:ListItem>-</asp:ListItem>
                                <asp:ListItem>Window</asp:ListItem>
                                <asp:ListItem>Door</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="DropDownList1"
                                ErrorMessage="specification is required" Text="*" ForeColor="Red" InitialValue="-"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:DropDownList ID="dlspecification" CssClass="tboxinput" runat="server">
                                <asp:ListItem>-</asp:ListItem>
                                <asp:ListItem>Window</asp:ListItem>
                                <asp:ListItem>Door</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="insertvalidation" runat="server" ControlToValidate="dlspecification"
                                Text="*" ForeColor="Red" ErrorMessage="specification is required" InitialValue="-"></asp:RequiredFieldValidator>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("SPECIFICATION") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="MOBILIZATIONCOST" SortExpression="MOBILIZATIONCOST">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox5" Width="70px" CssClass="tboxinput" runat="server" Text='<%# Bind("MOBILIZATIONCOST") %>'></asp:TextBox>
                            <asp:CompareValidator ID="CompareValidatoreditmobilization" runat="server" ForeColor="Red" ControlToValidate="TextBox5" Text="*"
                                Type="Double" Operator="DataTypeCheck" ErrorMessage="invalid amount"></asp:CompareValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("MOBILIZATIONCOST") %>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="tboxmobilizationcost" Width="70px" CssClass="tboxinput" runat="server"></asp:TextBox>
                            <asp:CompareValidator ID="CompareValidatorinsertmobilization" ValidationGroup="insertvalidation" runat="server" ControlToValidate="tboxmobilizationcost" Text="*"
                                Type="Double" Operator="DataTypeCheck" ErrorMessage="invalid amount" ForeColor="Red"></asp:CompareValidator>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnassessment" CssClass="gridbtn" runat="server" Text="assessment" />
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:ImageButton ID="ImageButton1" ValidationGroup="insertvalidation" ImageUrl="~/AFTERSALESPROJ/images/add.png" OnClick="lbtninsert_click" runat="server" />
                        </FooterTemplate>
                    </asp:TemplateField>

                </Columns>
                <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                <PagerSettings Position="TopAndBottom" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <RowStyle Font-Names="Segoe UI" Font-Size="10pt" Height="35px" BackColor="#EEEEEE" ForeColor="Black" />
                <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#0000A9" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#000065" />
            </asp:GridView>
            <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="insertvalidation" ForeColor="Red" runat="server" />
            <asp:ValidationSummary ID="ValidationSummary2" ForeColor="Red" runat="server" />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:sqlcon %>"
                DeleteCommand="DELETE FROM [REPORTTB] WHERE [ID] = @original_ID AND (([SID] = @original_SID) OR ([SID] IS NULL AND @original_SID IS NULL)) AND (([ITEMNO] = @original_ITEMNO) OR ([ITEMNO] IS NULL AND @original_ITEMNO IS NULL)) AND (([KNO] = @original_KNO) OR ([KNO] IS NULL AND @original_KNO IS NULL)) AND (([LOCATION] = @original_LOCATION) OR ([LOCATION] IS NULL AND @original_LOCATION IS NULL)) AND (([SPECIFICATION] = @original_SPECIFICATION) OR ([SPECIFICATION] IS NULL AND @original_SPECIFICATION IS NULL)) AND (([MOBILIZATIONCOST] = @original_MOBILIZATIONCOST) OR ([MOBILIZATIONCOST] IS NULL AND @original_MOBILIZATIONCOST IS NULL))"
                InsertCommand="
                declare @id as integer = (select max(id)+1 from reporttb)
                INSERT INTO [REPORTTB] ([ID], [SID], [ITEMNO], [KNO], [LOCATION], [SPECIFICATION], [MOBILIZATIONCOST]) VALUES (@ID, @SID, @ITEMNO, @KNO, @LOCATION, @SPECIFICATION, @MOBILIZATIONCOST)"
                OldValuesParameterFormatString="original_{0}"
                SelectCommand="SELECT [ID], [SID], [ITEMNO], [KNO], [LOCATION], [SPECIFICATION], [MOBILIZATIONCOST] FROM [REPORTTB] WHERE ([SID] = @SID)"
                UpdateCommand="UPDATE [REPORTTB] SET [SID] = @SID, [ITEMNO] = @ITEMNO, [KNO] = @KNO, [LOCATION] = @LOCATION, [SPECIFICATION] = @SPECIFICATION, [MOBILIZATIONCOST] = @MOBILIZATIONCOST WHERE [ID] = @original_ID AND (([SID] = @original_SID) OR ([SID] IS NULL AND @original_SID IS NULL)) AND (([ITEMNO] = @original_ITEMNO) OR ([ITEMNO] IS NULL AND @original_ITEMNO IS NULL)) AND (([KNO] = @original_KNO) OR ([KNO] IS NULL AND @original_KNO IS NULL)) AND (([LOCATION] = @original_LOCATION) OR ([LOCATION] IS NULL AND @original_LOCATION IS NULL)) AND (([SPECIFICATION] = @original_SPECIFICATION) OR ([SPECIFICATION] IS NULL AND @original_SPECIFICATION IS NULL)) AND (([MOBILIZATIONCOST] = @original_MOBILIZATIONCOST) OR ([MOBILIZATIONCOST] IS NULL AND @original_MOBILIZATIONCOST IS NULL))">
                <DeleteParameters>
                    <asp:Parameter Name="original_ID" Type="Int32" />
                    <asp:Parameter Name="original_SID" Type="String" />
                    <asp:Parameter Name="original_ITEMNO" Type="String" />
                    <asp:Parameter Name="original_KNO" Type="String" />
                    <asp:Parameter Name="original_LOCATION" Type="String" />
                    <asp:Parameter Name="original_SPECIFICATION" Type="String" />
                    <asp:Parameter Name="original_MOBILIZATIONCOST" Type="Decimal" />
                </DeleteParameters>
                <InsertParameters>
                    <%--     <asp:Parameter Name="ID" Type="Int32" />--%>
                    <asp:Parameter Name="SID" Type="String" />
                    <asp:Parameter Name="ITEMNO" Type="String" />
                    <asp:Parameter Name="KNO" Type="String" />
                    <asp:Parameter Name="LOCATION" Type="String" />
                    <asp:Parameter Name="SPECIFICATION" Type="String" />
                    <asp:Parameter Name="MOBILIZATIONCOST" Type="Decimal" />
                </InsertParameters>
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="" Name="SID" SessionField="SID" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SID" Type="String" />
                    <asp:Parameter Name="ITEMNO" Type="String" />
                    <asp:Parameter Name="KNO" Type="String" />
                    <asp:Parameter Name="LOCATION" Type="String" />
                    <asp:Parameter Name="SPECIFICATION" Type="String" />
                    <asp:Parameter Name="MOBILIZATIONCOST" Type="Decimal" />
                    <asp:Parameter Name="original_ID" Type="Int32" />
                    <asp:Parameter Name="original_SID" Type="String" />
                    <asp:Parameter Name="original_ITEMNO" Type="String" />
                    <asp:Parameter Name="original_KNO" Type="String" />
                    <asp:Parameter Name="original_LOCATION" Type="String" />
                    <asp:Parameter Name="original_SPECIFICATION" Type="String" />
                    <asp:Parameter Name="original_MOBILIZATIONCOST" Type="Decimal" />
                </UpdateParameters>
            </asp:SqlDataSource>

            <br />
         
            <br />

        </ContentTemplate>
    </asp:UpdatePanel>




    <div>
           <asp:HyperLink ID="goback0" runat="server" NavigateUrl="~/AFTERSALESPROJ/FRMservicingschedule.aspx" Text="&lt;&lt; Servicing Schedule"></asp:HyperLink>
        <br />
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:sqlcon %>" SelectCommand="SELECT * FROM [REPORTTB] WHERE ([SID] = @SID)">
            <SelectParameters>
                <asp:SessionParameter Name="SID" SessionField="SID" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:sqlcon %>" SelectCommand="SELECT * FROM [SERVICINGTB] WHERE ([ID] = @ID)">
            <SelectParameters>
                <asp:SessionParameter Name="ID" SessionField="SID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
    </div>

    <div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%" Height="700px" OnReportRefresh="ReportViewer1_ReportRefresh">
                    <LocalReport ReportPath="AFTERSALESPROJ\report\RPTassessment.rdlc">
                        <DataSources>
                            <rsweb:ReportDataSource DataSourceId="SqlDataSource2" Name="DataSet1" />
                            <rsweb:ReportDataSource DataSourceId="SqlDataSource3" Name="DataSet2" />
                        </DataSources>
                    </LocalReport>
                </rsweb:ReportViewer>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <div>
        <iframe style="position: absolute; width: 80%; border: none" src="FRMsignature.aspx" height="700"></iframe>
    </div>

</asp:Content>





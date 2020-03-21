<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="reportPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.reportPage" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/gridcss.css" rel="stylesheet" />
    <style type="text/css">
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        .tbl th, td {
            padding: 15px;
            text-align: left;
        }
        .tbl th, td{
               border: 0px solid black;
        }
        .tbl table{
            border: 1px solid black;
        
        }

        .tbl {
            border-collapse: collapse;
            width: 70%;
            margin-left: 15%;
            margin-right: 15%;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size:12px;
        }

        .tbdiv {
        }

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
    <div style="align-content: center">
        <asp:Label ID="lblproject" runat="server" Text="Project Name" Font-Bold="True" Font-Names="Calibri" Font-Size="25pt" ForeColor="#000066"></asp:Label>
        <br />
        <asp:Label ID="lbladdress" runat="server" Text="Address" Font-Names="Century Gothic" Font-Size="11pt" Font-Strikeout="False" ForeColor="Black"></asp:Label>
        <br />
        <asp:Label ID="lbldate" runat="server" Text="Date" Font-Names="Segoe UI" Font-Size="18pt" Font-Strikeout="False" ForeColor="#000066"></asp:Label>
        <br />
        <br />
        <div class="tbdiv">
            <table class="tbl">
                <tr>
                    <th>Status</th>
                    <th>Job Order No.</th>
                    <th>Color</th>
                    <th>Assigned Team</th>
                    <th>Members</th>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblstatus" runat="server" Text="Status"></asp:Label></td>
                    <td>
                        <asp:Label ID="lbljo" runat="server" Text="Job Order No."></asp:Label></td>
                    <td>
                        <asp:Label ID="lblcolor" runat="server" Text="Profile finish"></asp:Label></td>
                    <td>
                        <asp:Label ID="lblteamname" runat="server" Text="teamname"></asp:Label></td>
                    <td>
                        <asp:Label ID="lblpersonnel" runat="server" Text="personnel"></asp:Label></td>

                </tr>
            </table>
        </div>
    </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>

            <br />
            Report table<br />
            <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSource1"
                EmptyDataText="NO RESULT" EnablePersistedSelection="True"
                ShowFooter="True" OnPageIndexChanging="GridView2_PageIndexChanging"
                PageSize="5" OnRowDataBound="GridView2_RowDataBound"
                Font-Names="Segoe UI" Font-Size="12px" HorizontalAlign="Center">
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
                            <asp:LinkButton ID="LinkButton1" runat="server">assessment</asp:LinkButton>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:ImageButton ID="ImageButton1" ValidationGroup="insertvalidation" ImageUrl="~/AFTERSALESPROJ/images/add.png" OnClick="lbtninsert_click" runat="server" />
                        </FooterTemplate>
                    </asp:TemplateField>

                </Columns>
                <PagerSettings Position="TopAndBottom" />
                <RowStyle Font-Names="Segoe UI" Font-Size="10pt" Height="35px" />
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
    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/AFTERSALESPROJ/reportviewPage.aspx">View Report</asp:HyperLink>
</asp:Content>

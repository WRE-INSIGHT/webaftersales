<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="reportPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.reportPage" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .tbl td {
            padding-bottom: 10px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h1>
            <asp:Label ID="lblproject" runat="server" Text="Project Name"></asp:Label>
        </h1>
        <h4>
            <asp:Label ID="lbladdress" runat="server" Text="Address"></asp:Label></h4>
        <footer>
            <h2>
                <asp:Label ID="lbldate" runat="server" Text="Date"></asp:Label></h2>
            <h4><small>
                <asp:Label ID="lblservicing" runat="server" Text="Servicing"></asp:Label></small></h4>
        </footer>

    </div>

    <table class="table table-striped">
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


    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>

            <div class="well-sm">
                <strong>Report Table!</strong> List of items.
            </div>
            <asp:GridView ID="GridView2" class="table table-hover" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSource1"
                EmptyDataText="NO RESULT" EnablePersistedSelection="True"
                ShowFooter="True" OnPageIndexChanging="GridView2_PageIndexChanging"
                PageSize="5" OnRowDataBound="GridView2_RowDataBound" HorizontalAlign="Center">
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
                            <asp:TextBox ID="TextBox1" CssClass="form-control" runat="server" Text='<%# Bind("ITEMNO") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("ITEMNO") %>'></asp:Label>
                        </ItemTemplate>

                        <FooterTemplate>
                            <asp:TextBox ID="tboxitemno" CssClass="form-control" runat="server"></asp:TextBox>
                        </FooterTemplate>

                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="KNO" SortExpression="KNO">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" CssClass="form-control" runat="server" Text='<%# Bind("KNO") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("KNO") %>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="tboxkno" CssClass="form-control" runat="server"></asp:TextBox>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="LOCATION" SortExpression="LOCATION">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" CssClass="form-control" runat="server" Text='<%# Bind("LOCATION") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("LOCATION") %>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="tboxlocation" CssClass="form-control" runat="server"></asp:TextBox>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="SPECIFICATION" SortExpression="SPECIFICATION">
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownList1" CssClass="form-control" SelectedValue='<%# Bind("SPECIFICATION") %>' runat="server">
                                <asp:ListItem>-</asp:ListItem>
                                <asp:ListItem>Window</asp:ListItem>
                                <asp:ListItem>Door</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="DropDownList1"
                                ErrorMessage="specification is required" Text="*" ForeColor="Red" InitialValue="-"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:DropDownList ID="dlspecification" CssClass="form-control" runat="server">
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
                    <asp:TemplateField HeaderText="MOB COST" SortExpression="MOBILIZATIONCOST">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox5" CssClass="form-control" runat="server" Text='<%# Bind("MOBILIZATIONCOST") %>'></asp:TextBox>
                            <asp:CompareValidator ID="CompareValidatoreditmobilization" runat="server" ForeColor="Red" ControlToValidate="TextBox5" Text="*"
                                Type="Double" Operator="DataTypeCheck" ErrorMessage="invalid amount"></asp:CompareValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("MOBILIZATIONCOST") %>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="tboxmobilizationcost" CssClass="form-control" runat="server"></asp:TextBox>
                            <asp:CompareValidator ID="CompareValidatorinsertmobilization" ValidationGroup="insertvalidation" runat="server" ControlToValidate="tboxmobilizationcost" Text="*"
                                Type="Double" Operator="DataTypeCheck" ErrorMessage="invalid amount" ForeColor="Red"></asp:CompareValidator>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <%--   <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server">assessment</asp:LinkButton>
                        </ItemTemplate>--%>
                        <FooterTemplate>
                            <asp:ImageButton ID="ImageButton1" ValidationGroup="insertvalidation" ImageUrl="~/AFTERSALESPROJ/images/add.png" OnClick="lbtninsert_click" runat="server" />
                        </FooterTemplate>
                    </asp:TemplateField>

                </Columns>
                <PagerSettings Position="TopAndBottom" />
                <RowStyle Font-Names="Segoe UI" Font-Size="10pt" Height="35px" />
            </asp:GridView>

            <asp:ValidationSummary class="alert alert-danger" ID="ValidationSummary1" ValidationGroup="insertvalidation" runat="server" />
            <asp:ValidationSummary class="alert alert-danger" ID="ValidationSummary2" runat="server" />


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
            <div>
                <asp:Button ID="Button2" CssClass="btn btn-primary" runat="server" Text="Add New Item" data-toggle="modal" data-target="#myModal" />
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>





    <!-- Modal -->
    <div id="myModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">New Item</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <table class="tbl">
                            <tr>
                                <td>
                                    <asp:TextBox CssClass="form-control" Height="40" placeholder="Item number" ID="tboxitemno" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox CssClass="form-control" Height="40" ID="tboxkno" placeholder="K number" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox CssClass="form-control" Height="40" ID="tboxlocation" placeholder="Location" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td></td>
                            </tr>
                            <tr>
                                <td style="width: 100%">
                                    <asp:DropDownList ID="dlistspecification" Height="40" placeholder="Specification" CssClass="form-control" runat="server">
                                        <asp:ListItem>-</asp:ListItem>
                                        <asp:ListItem>Window</asp:ListItem>
                                        <asp:ListItem>Door</asp:ListItem>
                                    </asp:DropDownList></td>
                                <td>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="dlistspecification" ValidationGroup="validationpopup"
                                        ErrorMessage="specification is required" Text="*" ForeColor="Red" InitialValue="-"></asp:RequiredFieldValidator></td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox CssClass="form-control" Height="40" ID="tboxmobilizationcost" placeholder="Mobilization Cost" runat="server"></asp:TextBox></td>
                                <td>
                                    <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="invalid amount" Text="*"
                                        ControlToValidate="tboxmobilizationcost" Type="Double" Operator="DataTypeCheck" ValidationGroup="validationpopup"
                                        ForeColor="Red"></asp:CompareValidator></td>
                            </tr>
                        </table>
                    </div>

                    <div class="form-group">
                        <asp:ValidationSummary ID="validationpopup" class="alert alert-danger" ValidationGroup="validationpopup" runat="server" />
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="Button1" ValidationGroup="validationpopup" CssClass="btn btn-default" runat="server" Text=" Add " OnClick="addbtn_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Exit</button>
                </div>
            </div>

        </div>
    </div>
    <br />
    <br />
    <asp:LinkButton ID="LinkButton1" Width="100%" CssClass="btn btn-primary" runat="server" PostBackUrl="~/AFTERSALESPROJ/reportviewPage.aspx">VIEW REPORT</asp:LinkButton>

</asp:Content>

<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="reportPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.reportPage" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Report</title>
    <style>
        .tbl td {
            padding-bottom: 10px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">

        <strong>
            <asp:Label ID="lblproject" Font-Size="X-Large" runat="server" Text="Project Name"></asp:Label></strong><br />

        <asp:Label ID="lbladdress" Font-Size="Medium" CssClass="text-info" runat="server" Text="Address"></asp:Label><br />
        <asp:Label ID="lbljo" Font-Size="Medium" runat="server" Text="Job Order No."></asp:Label><br />
        <div class="navbar-right">
            <asp:HyperLink ID="HyperLink4" CssClass="btn btn-default" NavigateUrl="~/AFTERSALESPROJ/homePage.aspx" runat="server" Text="back"></asp:HyperLink>
        </div>
    </div>
    <h2>
        <asp:Label ID="lbldate" runat="server" Text="Date"></asp:Label>
        <small>
            <asp:Label ID="lblservicing" runat="server" Text="Servicing"></asp:Label></small></h2>

    <table class="table table-striped">
        <tr>
            <th>Status</th>
            <th>Color</th>
            <th>Team</th>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblstatus" runat="server" Text="Status"></asp:Label></td>
            <td>
                <asp:Label ID="lblcolor" runat="server" Text="Profile finish"></asp:Label></td>
            <td>
                <asp:Label ID="lblteamname" runat="server" CssClass="text-center" Text="teamname"></asp:Label><br />
                <asp:Label ID="lblpersonnel" runat="server" Text="personnel"></asp:Label></td>
        </tr>
    </table>


    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>

            <div class="well">
                <strong>Report Table!</strong> List of items.
            </div>

            <div class="panel">
                <asp:GridView ID="GridView1" Visible="false" OnRowCommand="GridView1_RowCommand" ShowHeader="false" GridLines="None" runat="server" AutoGenerateColumns="False" AllowPaging="True">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <asp:Label ID="lbllocation" Font-Size="Large" runat="server" Text='<%# Bind("LOCATION") %>'></asp:Label>
                                        <asp:LinkButton ID="LinkButton4" CommandName="myedit" CssClass="text-right" runat="server">Edit</asp:LinkButton>
                                    </div>
                                    <div class="panel-body">
                                        <asp:Label ID="lblid" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                        <asp:Label ID="lblsid" Visible="false" runat="server" Text='<%# Bind("SID") %>'></asp:Label>
                                        <asp:Label ID="lbljo" Visible="false" runat="server" Text='<%# Bind("JO") %>'></asp:Label>
                                        <asp:Label ID="lblspecification" Font-Size="Medium" runat="server" Text='<%# Bind("SPECIFICATION") %>'></asp:Label><br />
                                        <table class="table" border="1">
                                            <tr>
                                                <th>Item#</th>
                                                <th>K#</th>
                                                <th>Mobilization cost</th>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblitemno" runat="server" Text='<%# Bind("ITEMNO") %>'></asp:Label></td>
                                                <td>
                                                    <asp:Label ID="lblkno" runat="server" Text='<%# Bind("KNO") %>'></asp:Label></td>
                                                <td>
                                                    <asp:Label ID="lblmobilization" runat="server" Text='<%# Bind("MOBILIZATIONCOST") %>'></asp:Label></td>
                                            </tr>
                                        </table>
                                        <asp:Button ID="Button2" CssClass="btn btn-default" CommandName="myassessment" runat="server" Text="assessment" />
                                
                                                <asp:Panel ID="Panel1" Visible="false" runat="server">
                                                    <div class="well">
                                                        Item#<br />
                                                        <asp:TextBox ID="tboxitemno" CssClass="form-control" runat="server"></asp:TextBox><br />
                                                        K#<br />
                                                        <asp:TextBox ID="tboxkno" CssClass="form-control" runat="server"></asp:TextBox><br />
                                                        Location<br />
                                                        <asp:TextBox ID="tboxlocation" CssClass="form-control" runat="server"></asp:TextBox><br />
                                                        Specification 
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="dlistspecification" ValidationGroup="editval"
                                                    ErrorMessage="specification is required" Text="*" ForeColor="Red" InitialValue="-"></asp:RequiredFieldValidator><br />
                                                        <asp:DropDownList ID="dlistspecification" placeholder="Specification" CssClass="form-control" runat="server">
                                                            <asp:ListItem>-</asp:ListItem>
                                                            <asp:ListItem>Window</asp:ListItem>
                                                            <asp:ListItem>Door</asp:ListItem>
                                                        </asp:DropDownList><br />

                                                        Mobilization cost 
                                                <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="invalid amount" Text="*"
                                                    ControlToValidate="tboxmobilizationcost" Type="Double" Operator="DataTypeCheck" ValidationGroup="editval"
                                                    ForeColor="Red"></asp:CompareValidator><br />
                                                        <asp:TextBox ID="tboxmobilizationcost" CssClass="form-control" runat="server"></asp:TextBox><br />
                                                        <asp:ValidationSummary ID="ValidationSummary3" ValidationGroup="editval" CssClass="aler alert-danger" runat="server" />
                                                        <asp:Button ID="Button3" CommandName="mysave" CssClass="btn btn-primary" ValidationGroup="editval" runat="server" Text="save" />
                                                        <asp:Button ID="Button4" CommandName="mycancel" CssClass="btn btn-default" runat="server" Text="cancel" />
                                                    </div>
                                                </asp:Panel>
                                 

                                    </div>

                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle CssClass="GridPager" HorizontalAlign="Center" />
                    <EmptyDataTemplate>
                        <div class="alert alert-danger">
                            <h2><strong>Sorry, no data available!</strong>
                                <small>0 result found</small>
                            </h2>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>


            <br />
            <div class="panel panel-primary">
                <div class=" panel-heading">
                    <div class="container">
                        <asp:HyperLink ID="HyperLink3" CssClass="btn btn-default" runat="server" data-toggle="modal" data-target="#myModal">add new item</asp:HyperLink>
                        <asp:HyperLink ID="HyperLink1" CssClass="btn btn-warning" runat="server" NavigateUrl="~/AFTERSALESPROJ/importPage.aspx">import items</asp:HyperLink>
                        <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" OnClick="LinkButton2_Click">view report</asp:LinkButton>
                        <asp:LinkButton ID="LinkButton3" runat="server" CssClass="btn btn-danger" OnClick="LinkButton3_Click">see photos</asp:LinkButton>
                    </div>
                </div>
                <div class="panel-body">


                    <asp:GridView ID="GridView2" class="table table-hover" GridLines="None" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSource1"
                        EmptyDataText="NO RESULT" EnablePersistedSelection="True"
                        ShowFooter="True" OnPageIndexChanging="GridView2_PageIndexChanging"
                        PageSize="5" OnRowDataBound="GridView2_RowDataBound" HorizontalAlign="Center" OnRowCommand="GridView2_RowCommand" OnSelectedIndexChanged="GridView2_SelectedIndexChanged">
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

                            <asp:TemplateField HeaderText="" SortExpression="JO">
                                <EditItemTemplate>
                                    <asp:Label ID="Label100" Visible="false" runat="server" Text='<%# Bind("JO") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label600" Visible="false" runat="server" Text='<%# Bind("JO") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" CssClass="btn btn-primary" CommandName="assessment" runat="server">assessment</asp:LinkButton>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:ImageButton ID="ImageButton1" ValidationGroup="insertvalidation" ImageUrl="~/AFTERSALESPROJ/images/add.png" OnClick="lbtninsert_click" runat="server" />
                                </FooterTemplate>
                            </asp:TemplateField>

                        </Columns>
                        <PagerStyle CssClass="GridPager" HorizontalAlign="Center" />
                        <RowStyle Font-Names="Segoe UI" Font-Size="10pt" Height="35px" />
                        <EmptyDataTemplate>
                            <div class="alert alert-danger">
                                <h2><strong>Sorry, no data available!</strong>
                                    <small>0 result found</small>
                                </h2>
                            </div>
                        </EmptyDataTemplate>
                    </asp:GridView>

                    <asp:ValidationSummary class="alert alert-danger" ID="ValidationSummary1" ValidationGroup="insertvalidation" runat="server" />
                    <asp:ValidationSummary class="alert alert-danger" ID="ValidationSummary2" runat="server" />
                </div>
                <div class="panel-footer">
                    Footer
                </div>
            </div>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sqlcon %>"
                DeleteCommand="DELETE FROM [REPORTTB] WHERE [ID] = @ID"
                InsertCommand="
                declare @id as integer = (select isnull(max(isnull(id,0)),0)+1 from reporttb)
                INSERT INTO [REPORTTB] ([ID], [SID], [KNO], [ITEMNO], [LOCATION], [SPECIFICATION], [MOBILIZATIONCOST], [JO]) VALUES (@ID, @SID, @KNO, @ITEMNO, @LOCATION, @SPECIFICATION, @MOBILIZATIONCOST, @JO)"
                SelectCommand="SELECT * FROM [REPORTTB] WHERE ([SID] = @SID)"
                UpdateCommand="UPDATE [REPORTTB] SET [SID] = @SID, [KNO] = @KNO, [ITEMNO] = @ITEMNO, [LOCATION] = @LOCATION, [SPECIFICATION] = @SPECIFICATION, [MOBILIZATIONCOST] = @MOBILIZATIONCOST, [JO] = @JO WHERE [ID] = @ID">
                <DeleteParameters>
                    <asp:Parameter Name="ID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>

                    <asp:Parameter Name="SID" Type="String" />
                    <asp:Parameter Name="KNO" Type="String" />
                    <asp:Parameter Name="ITEMNO" Type="String" />
                    <asp:Parameter Name="LOCATION" Type="String" />
                    <asp:Parameter Name="SPECIFICATION" Type="String" />
                    <asp:Parameter Name="MOBILIZATIONCOST" Type="Decimal" />
                    <asp:Parameter Name="JO" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:SessionParameter Name="SID" SessionField="SID" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SID" Type="String" />
                    <asp:Parameter Name="KNO" Type="String" />
                    <asp:Parameter Name="ITEMNO" Type="String" />
                    <asp:Parameter Name="LOCATION" Type="String" />
                    <asp:Parameter Name="SPECIFICATION" Type="String" />
                    <asp:Parameter Name="MOBILIZATIONCOST" Type="Decimal" />
                    <asp:Parameter Name="JO" Type="String" />
                    <asp:Parameter Name="ID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
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


</asp:Content>

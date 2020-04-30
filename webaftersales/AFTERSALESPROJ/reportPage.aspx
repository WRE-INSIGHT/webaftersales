<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="reportPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.reportPage" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Report</title>
    <style>
        .tbl td {
            padding-bottom: 10px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Report</strong></h3>
        <div class="navbar-right">
            <asp:HyperLink ID="HyperLink4" CssClass="btn btn-default" NavigateUrl="~/AFTERSALESPROJ/homePage.aspx" runat="server" Text="back"></asp:HyperLink>
        </div>
    </div>

    <strong>
        <asp:Label ID="lblproject" Font-Size="X-Large" runat="server" Text="Project Name"></asp:Label></strong><br />
    <asp:Label ID="lbladdress" Font-Size="Medium" runat="server" Text="Address"></asp:Label><br />
    <asp:Label ID="lbljo" Font-Size="Medium" runat="server" Text="Job Order No."></asp:Label><br />
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


            <div class="panel panel-primary">
                <div class="panel-body">
                    <strong>Options</strong><br />

                    <asp:HyperLink ID="HyperLink1" CssClass="btn btn-default" runat="server" NavigateUrl="~/AFTERSALESPROJ/importPage.aspx">import</asp:HyperLink>
                    <asp:LinkButton ID="LinkButton2" CssClass="btn btn-default" runat="server" OnClick="LinkButton2_Click">report</asp:LinkButton>
                    <asp:LinkButton ID="LinkButton3" CssClass="btn btn-default" runat="server" OnClick="LinkButton3_Click">photos</asp:LinkButton>


                </div>
            </div>
            <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="val1" runat="server" />
            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                <ContentTemplate>
                    <div class="panel-group">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <asp:HyperLink ID="HyperLink2" runat="server" data-toggle="collapse" href="#collapse1"><span class="glyphicon glyphicon-resize-vertical"></span>&nbsp;add new item</asp:HyperLink>
                                </h4>
                            </div>
                            <div id="collapse1" class="panel-collapse collapse">
                                <div class="panel-body">
                                    Item#<br />
                                    <asp:TextBox ID="newtboxitemno" placeholder="Item number" CssClass="form-control" runat="server"></asp:TextBox><br />
                                    K#<br />
                                    <asp:TextBox ID="newtboxkno" placeholder="k number" CssClass="form-control" runat="server"></asp:TextBox><br />
                                    Location<br />
                                    <asp:TextBox ID="newtboxlocation" placeholder="Location" CssClass="form-control" runat="server"></asp:TextBox><br />
                                    Specification 
                                                <asp:RequiredFieldValidator ID="newdlistspecificationvalidator" runat="server" ControlToValidate="newdlistspecification" ValidationGroup="newval"
                                                    ErrorMessage="specification is required" Text="*" ForeColor="Red" InitialValue="-"></asp:RequiredFieldValidator><br />
                                    <asp:DropDownList ID="newdlistspecification" placeholder="Specification" CssClass="form-control" runat="server">
                                        <asp:ListItem>-</asp:ListItem>
                                        <asp:ListItem>Window</asp:ListItem>
                                        <asp:ListItem>Door</asp:ListItem>
                                    </asp:DropDownList><br />

                                    Mobilization cost 
                                                <asp:CompareValidator ID="newtboxmobilizationcostvalidator" runat="server" ErrorMessage="invalid amount" Text="*"
                                                    ControlToValidate="newtboxmobilizationcost" Type="Double" Operator="DataTypeCheck" ValidationGroup="newval"
                                                    ForeColor="Red"></asp:CompareValidator><br />
                                    <asp:TextBox ID="newtboxmobilizationcost" placeholder="Mobilization cost" CssClass="form-control" runat="server"></asp:TextBox><br />

                                    <asp:Button ID="newbtn" OnClick="newbtn_click" CssClass="btn btn-primary" ValidationGroup="newval" runat="server" Text="add" />
                                    <asp:ValidationSummary ID="valsummary" ValidationGroup="newval" CssClass="alert alert-danger" runat="server" />
                                </div>
                                <div class="panel-footer">Footer</div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <br />
            <div class="panel panel-primary">

                <div class="panel-body">
                    <asp:GridView ID="GridView1" OnRowCommand="GridView1_RowCommand" ShowHeader="false" GridLines="None" runat="server" AutoGenerateColumns="False" AllowPaging="True" PageSize="5" OnPageIndexChanging="GridView1_PageIndexChanging">
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
                                                <tr>
                                                    <td colspan="3">
                                                        <asp:Button ID="Button2" CssClass="btn btn-default" CommandName="myassessment" runat="server" Text="assessment" />
                                                    </td>
                                                </tr>
                                            </table>

                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                <ContentTemplate>
                                                    <asp:Panel ID="Panel1" Visible="false" runat="server">
                                                        <div class="panel panel-primary">
                                                            <div class="panel-body">
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

                                                            </div>
                                                            <div class="panel-footer">
                                                                <asp:Button ID="Button4" CommandName="mycancel" CssClass="btn btn-default" runat="server" Text="cancel" />
                                                                <div class="navbar-right">
                                                                    <asp:LinkButton ID="LinkButton5" OnClientClick="return confirm('delete this item?')" CommandName="mydelete" CssClass="btn btn-default" runat="server"><span class="glyphicon glyphicon-trash"></span></asp:LinkButton>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </asp:Panel>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>

                                        </div>

                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerSettings PageButtonCount="8" />
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

            </div>
            <br />



        </ContentTemplate>
    </asp:UpdatePanel>






</asp:Content>

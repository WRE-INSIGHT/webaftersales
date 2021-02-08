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
            <asp:LinkButton ID="LinkButton6" CssClass="btn btn-default" runat="server" OnClick="LinkButton6_Click">back</asp:LinkButton>

        </div>
    </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <strong>
        <asp:Label ID="lblproject" Font-Size="X-Large" runat="server" Text="Project Name"></asp:Label></strong><br />
    <asp:Label ID="lbladdress" Font-Size="Medium" runat="server" Text="Address"></asp:Label><br />
    <asp:Label ID="lbljo" Font-Size="Medium" runat="server" Text="Job Order No."></asp:Label><br />
    <h2>
        <asp:Label ID="lbldate" runat="server" Text="Date"></asp:Label>
        <small>
            <asp:Label ID="lblservicing" runat="server" Text="Servicing"></asp:Label></small></h2>

    <table class="table" border="1">
        <tr>
            <th>Status</th>
            <th>Color</th>
            <th>Team</th>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblstatus" runat="server" Text="Status"></asp:Label>
                <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">Edit</asp:LinkButton>
            </td>
            <td>
                <asp:Label ID="lblcolor" runat="server" Text="Profile finish"></asp:Label></td>
            <td>
                <asp:Label ID="lblteamname" runat="server" CssClass="text-center" Text="teamname"></asp:Label><br />
                <asp:Label ID="lblpersonnel" runat="server" Text="personnel"></asp:Label></td>
        </tr>
        <tr>
            <td>
                <small>Remarks</small>
            </td>
            <td colspan="2">
                <asp:Label ID="lblremarks" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:Panel ID="Panel2" Visible="false" runat="server">

                    <div class="well">
                        Status:<br />
                        <asp:DropDownList ID="statusddl" Height="35" CssClass="form-control" runat="server">
                            <asp:ListItem>Scheduled</asp:ListItem>
                            <asp:ListItem>Pending For Reschedule</asp:ListItem>
                        </asp:DropDownList>
                        <br />
                        Remarks:<br />
                        <asp:TextBox ID="reasontbox" runat="server" TextMode="MultiLine" Rows="4" CssClass=" form-control"></asp:TextBox><br />
                        <asp:Button ID="Button1" Height="35" CssClass="btn btn-default" OnClientClick="return confirm('save changes?')" runat="server" Text="save" OnClick="Button1_Click" />
                        <asp:Button ID="closebtn" Height="35" CssClass="btn btn-default" runat="server" Text="close" OnClick="closebtn_Click" />
                    </div>
                </asp:Panel>
            </td>
        </tr>
    </table>



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
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <asp:HyperLink ID="HyperLink2" runat="server" data-toggle="collapse" href="#collapse1"><span class="glyphicon glyphicon-resize-vertical"></span>&nbsp;add new item</asp:HyperLink>
                                </h4>
                            </div>
                            <div id="collapse1" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            Item#<br />
                                            <asp:TextBox ID="newtboxitemno" placeholder="Item number" CssClass="form-control" runat="server"></asp:TextBox><br />
                                            K#<br />
                                            <asp:TextBox ID="newtboxkno" placeholder="k number" CssClass="form-control" runat="server"></asp:TextBox><br />
                                            Width<br />
                                            <asp:TextBox ID="newtboxwidth" placeholder="Width" CssClass="form-control" runat="server"></asp:TextBox><br />
                                            Height<br />
                                            <asp:TextBox ID="newtboxheight" placeholder="Height" CssClass="form-control" runat="server"></asp:TextBox><br />
                                        </div>
                                        <div class="col-sm-6">
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


                                            <asp:Button ID="newbtn" OnClick="newbtn_click" CssClass="btn btn-primary" ValidationGroup="newval" runat="server" Text="add" />
                                        </div>
                                    </div>


                                    <asp:ValidationSummary ID="valsummary" ValidationGroup="newval" CssClass="alert alert-danger" runat="server" />
                                </div>
                                <div class="panel-footer">Footer</div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <br />

            <asp:GridView ID="GridView1" CssClass="table" OnRowCommand="GridView1_RowCommand" GridLines="Both" runat="server" AutoGenerateColumns="False" AllowPaging="True" PageSize="20" OnPageIndexChanging="GridView1_PageIndexChanging" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                <AlternatingRowStyle BackColor="#DCDCDC" />
                <Columns>
                    <asp:TemplateField HeaderText="" ItemStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblid" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                            <asp:Label ID="lblsid" Visible="false" runat="server" Text='<%# Bind("SID") %>'></asp:Label>

                            <asp:LinkButton ID="btnedit" CommandName="myedit" runat="server">Edit</asp:LinkButton>&nbsp;|&nbsp;
                            <asp:LinkButton ID="btndelete" OnClientClick="return confirm('delete this item?')" CommandName="mydelete" runat="server">Delete</asp:LinkButton>
                            <asp:LinkButton ID="btnsave" CommandName="mysave" Visible="false" ValidationGroup="editval" runat="server">Save</asp:LinkButton>&nbsp;|&nbsp;
                            <asp:LinkButton ID="btncancel" CommandName="mycancel" Visible="false" runat="server">Cancel</asp:LinkButton>
                        </ItemTemplate>
                        <ItemStyle Wrap="False" />
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lbljo" runat="server" Text='<%# Bind("JO") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Location" ItemStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lbllocation" runat="server" Text='<%# Bind("LOCATION") %>'></asp:Label>
                            <asp:TextBox ID="tboxlocation" Visible="false" CssClass="form-control" runat="server"></asp:TextBox>
                        </ItemTemplate>
                        <ItemStyle Wrap="False" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Specification" ItemStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblspecification" runat="server" Text='<%# Bind("SPECIFICATION") %>'></asp:Label>
                            <asp:DropDownList ID="dlistspecification" Visible="false" placeholder="Specification" CssClass="form-control" runat="server">
                                <asp:ListItem>-</asp:ListItem>
                                <asp:ListItem>Window</asp:ListItem>
                                <asp:ListItem>Door</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="dlistspecification" ValidationGroup="editval"
                                ErrorMessage="specification is required" ForeColor="Red" InitialValue="-"></asp:RequiredFieldValidator><br />

                        </ItemTemplate>
                        <ItemStyle Wrap="False" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Item#" ItemStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblitemno" runat="server" Text='<%# Bind("ITEMNO") %>'></asp:Label>
                            <asp:TextBox ID="tboxitemno" Visible="false" CssClass="form-control" runat="server"></asp:TextBox>
                        </ItemTemplate>
                        <ItemStyle Wrap="False" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="K#" ItemStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblkno" runat="server" Text='<%# Bind("KNO") %>'></asp:Label>
                            <asp:TextBox ID="tboxkno" Visible="false" CssClass="form-control" runat="server"></asp:TextBox>

                        </ItemTemplate>
                        <ItemStyle Wrap="False" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Width" ItemStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblwidth" runat="server" Text='<%# Bind("WIDTH") %>'></asp:Label>
                            <asp:TextBox ID="tboxwidth" Visible="false" CssClass="form-control" runat="server"></asp:TextBox>
                        </ItemTemplate>
                        <ItemStyle Wrap="False" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Height" ItemStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblheight" runat="server" Text='<%# Bind("HEIGHT") %>'></asp:Label>
                            <asp:TextBox ID="tboxheight" Visible="false" CssClass="form-control" runat="server"></asp:TextBox>
                        </ItemTemplate>
                        <ItemStyle Wrap="False" />
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Button ID="Button2" CssClass="btn btn-default" Width="100" CommandName="myassessment" runat="server" Text="assessment" />
                            <asp:Button ID="Button5" CssClass="btn btn-default" Width="100" CommandName="myquotation" runat="server" Text="proposal" />
                            <asp:Button ID="Button3" CssClass="btn btn-default" Width="100" CommandName="myphotos" runat="server" Text="photos" />
                        </ItemTemplate>
                        <ItemStyle Wrap="False" />
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                <PagerSettings PageButtonCount="8" />
                <PagerStyle CssClass="GridPager" HorizontalAlign="Center" BackColor="#999999" ForeColor="Black" />
                <EmptyDataTemplate>
                    <div class="">
                        <h2><strong>This table is empty!</strong>
                            <small>there are no k#(s) inputs.</small>
                        </h2>
                    </div>
                </EmptyDataTemplate>
                <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#0000A9" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#000065" />
            </asp:GridView>

            <br />



        </ContentTemplate>
    </asp:UpdatePanel>






</asp:Content>

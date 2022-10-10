<%@ Page Language="C#" MaintainScrollPositionOnPostback="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="newcallin.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.newcallin" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>manage call-in</title>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="">
        <h3><strong>Manage call-in</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-warning" PostBackUrl="~/AFTERSALESPROJ/CallinPage.aspx" runat="server">back</asp:LinkButton>
        </div>
    </div>

    <div class="navbar-left">
        <asp:TextBox ID="cin" CssClass="form-control" placeholder="CIN" runat="server"></asp:TextBox>
    </div>

    <br />
    <div class="well" style="background-color: whitesmoke">
        <span style="font-size: larger">Caller's Information</span>
        <div class="row">
            <div class="col-sm-4">
                <br />
                <span class="text-info">Date</span>
                <br />
                <asp:TextBox ID="calldate" CssClass="form-control" TextMode="Date" placeholder="mm/dd/yyyy" runat="server"></asp:TextBox>
                <span class="text-info">Caller</span>
                <br />
                <asp:TextBox ID="callername" CssClass="form-control" placeholder="Caller" runat="server"></asp:TextBox><br />
            </div>
            <div class="col-sm-8">
                <div class="row">
                    <div class="col-sm-6">
                        <span class="text-info">Contact person</span>
                        <br />
                        <asp:TextBox ID="contactpersontbox" CssClass="form-control" runat="server"></asp:TextBox>
                        <span class="text-info">Telephone number</span>
                        <br />
                        <asp:TextBox ID="telno" CssClass="form-control" runat="server"></asp:TextBox>
                        <span class="text-info">Email address</span>
                        <br />
                        <asp:TextBox ID="emailtbox" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-sm-6">
                        <span class="text-info">Viber account number</span>
                        <br />
                        <asp:TextBox ID="vibertbox" CssClass="form-control" runat="server"></asp:TextBox>
                        <span class="text-info">WhatsApp account number</span>
                        <br />
                        <asp:TextBox ID="whatsapptbox" CssClass="form-control" runat="server"></asp:TextBox>
                        <span class="text-info">Fax number</span>
                        <br />
                        <asp:TextBox ID="faxno" CssClass="form-control" runat="server" OnTextChanged="faxno_TextChanged"></asp:TextBox>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--   <div class="panel-group">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <asp:HyperLink ID="HyperLink1" runat="server" data-toggle="collapse" href="#collapse1"><span class="glyphicon glyphicon-resize-vertical"></span>&nbsp;Select project</asp:HyperLink>
                </h4>
            </div>
            <div id="collapse1" class="panel-collapse collapse">
                <div class="panel-body">
                </div>
                <div class="panel-footer">Footer</div>
            </div>
        </div>
    </div>
    <br />--%>

    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <div class="well" style="background-color: azure">
                <div class="row">
                    <div class="col-sm-4">
                        <span style="font-size: larger">Select a project / <small>
                            <asp:LinkButton ID="LinkButton4" PostBackUrl="~/AFTERSALESPROJ/projectList.aspx" runat="server">manage project list</asp:LinkButton></small></span>
                        <div class="input-group">
                            <asp:TextBox ID="keytbox" CssClass="form-control" runat="server"></asp:TextBox>
                            <div class="input-group-btn">
                                <asp:LinkButton ID="LinkButton2" OnClick="LinkButton2click" CssClass="btn btn-primary" runat="server">Find</asp:LinkButton>
                            </div>
                        </div>
                        <asp:Panel ID="Panel1" ScrollBars="Auto" runat="server">
                            <asp:GridView ID="GridView1" Width="100%" GridLines="None" AutoGenerateColumns="false" AllowPaging="true" PageSize="5" runat="server"
                                OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <div style="padding: 5px;">
                                                <asp:LinkButton ID="bindProject" CommandName="myselect" Text='<%# Eval("PROJECT") %>' Font-Size="Small" Font-Bold="true" runat="server"></asp:LinkButton><br />
                                                <asp:Label ID="bindAddress" Font-Size="small" runat="server" Text='<%# Bind("ADDRESS") %>'></asp:Label><br />
                                                ---><asp:Label ID="bindJo" Font-Size="small" runat="server" Text='<%# Bind("JO") %>'></asp:Label><---
                                            <asp:Label ID="bindParentJo" Visible="false" Font-Size="small" runat="server" Text='<%# Bind("JO") %>'></asp:Label>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <PagerSettings PageButtonCount="8" />
                                <PagerStyle CssClass="GridPager" HorizontalAlign="Center" />
                                <SelectedRowStyle BackColor="#CCCCFF" Font-Bold="True" />
                                <EmptyDataTemplate>
                                    <div class="alert alert-info" style="width: 100%">
                                        <h2><strong>No project found</strong>
                                        </h2>
                                    </div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </asp:Panel>
                    </div>
                    <div class="col-sm-8">
                        <asp:Panel ID="pnlKno" Visible="false" runat="server">
                            <br />
                            <div class="row">
                                <div class="col-sm-6">
                                </div>
                                <div class="col-sm-6">
                                    <span>Search k# by location
                                    </span>
                                    <div class="input-group">
                                        <asp:DropDownList ID="ddlLocation" CssClass="form-control" runat="server"></asp:DropDownList>
                                        <div class="input-group-btn">
                                            <asp:LinkButton ID="LinkButton5" CssClass="btn btn-primary" runat="server" OnClick="LinkButton5_Click">Find</asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <asp:Panel ID="Panel2" BackColor="Silver" runat="server">
                                <div style="max-height: 450px; overflow-y: auto">
                                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="false" Width="100%" BackColor="White" BorderColor="#999999" BorderStyle="None"
                                        BorderWidth="1px" CellPadding="3" GridLines="Vertical">
                                        <Columns>
                                            <asp:TemplateField ItemStyle-Wrap="false">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="cboxSelect" Text='<%# Bind("kmdi_no") %>' runat="server" />
                                                    <asp:Label ID="lblkno" Font-Size="Small" Visible="false" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Description">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbllocation" runat="server" Font-Size="Small" Text='<%# Bind("location") %>'></asp:Label><br />
                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                        -<asp:Label ID="lbldescription" Font-Size="Smaller" runat="server" Text='<%# Bind("description") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <a data-toggle="collapse" href='<%# "#"+Eval("Id") %>' role="button" aria-expanded="false" aria-controls="collapseExample">
                                                        <span>Concerns
                                                        </span>
                                                    </a>
                                                    <div class="collapse" id='<%# Eval("Id") %>'>
                                                        <div>
                                                            <asp:CheckBoxList ID="cblConcern" Font-Size="Small" runat="server">
                                                                <asp:ListItem>Hardware</asp:ListItem>
                                                                <asp:ListItem>Delamination</asp:ListItem>
                                                                <asp:ListItem>Glass Breakage</asp:ListItem>
                                                                <asp:ListItem>Discoloration/Stains</asp:ListItem>
                                                                <asp:ListItem>Leak</asp:ListItem>
                                                                <asp:ListItem>Torn Mesh</asp:ListItem>
                                                                <asp:ListItem>Cut String</asp:ListItem>
                                                                <asp:ListItem>Stuck-up</asp:ListItem>
                                                            </asp:CheckBoxList>
                                                            <asp:TextBox runat="server" ID="tboxConcern" placeholder="Other concern" CssClass="form-control"></asp:TextBox>
                                                        </div>

                                                    </div>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                        </Columns>
                                        <AlternatingRowStyle BackColor="#DCDCDC" />
                                        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                                        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle CssClass="GridPager" HorizontalAlign="Center" />
                                        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                                        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                                        <EmptyDataTemplate>
                                            <div class="alert alert-info" style="width: 100%">
                                                <h2><strong>No k# found</strong>
                                                </h2>
                                            </div>
                                        </EmptyDataTemplate>
                                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                        <SortedAscendingHeaderStyle BackColor="#0000A9" />
                                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                        <SortedDescendingHeaderStyle BackColor="#000065" />
                                    </asp:GridView>
                                </div>

                            </asp:Panel>
                            <asp:LinkButton ID="LinkButton6" runat="server" CssClass="btn btn-success" OnClick="LinkButton6_Click">submit concern</asp:LinkButton>
                        </asp:Panel>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <br />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="well" style="background-color: floralwhite">
                <div class="row">
                    <div class="col-sm-4">
                        <span>PROJECT NAME</span>
                        <asp:TextBox ID="projectname" CssClass="form-control" placeholder="Project Name" runat="server" Enabled="False"></asp:TextBox>
                        <span>ADDRESS</span>
                        <asp:TextBox ID="address" CssClass="form-control" placeholder="Address" runat="server" Enabled="False"></asp:TextBox>
                        <span>PARENTJO</span>
                        <asp:TextBox ID="parentjo" CssClass="form-control" placeholder="Parent JO" runat="server" Enabled="False"></asp:TextBox>
                        <span>JO</span>
                        <div class="input-group">
                            <asp:TextBox ID="jo" CssClass="form-control" placeholder="Job order number" runat="server" Enabled="False"></asp:TextBox>
                            <div class="input-group-btn">
                                <asp:LinkButton ID="LinkButton3" CssClass="btn btn-danger" runat="server" OnClick="LinkButton3_Click">clear project</asp:LinkButton>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-8">
                        <a data-toggle="collapse" href="#div_pnl_collapse" role="button" aria-expanded="false" aria-controls="collapseExample">
                            <span>Add Concerns</span>
                        </a>
                        <br />
                        <div class="collapse" id="div_pnl_collapse">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <div class="col-md-6">
                                        <span>K#/Location/Description</span>
                                        <asp:TextBox ID="tboxItemManual" CssClass="form-control" runat="server"></asp:TextBox>
                                        <span>Select Concerns</span>
                                        <asp:CheckBoxList ID="cblConcernManual" Font-Size="Small" runat="server">
                                            <asp:ListItem>Hardware</asp:ListItem>
                                            <asp:ListItem>Delamination</asp:ListItem>
                                            <asp:ListItem>Glass Breakage</asp:ListItem>
                                            <asp:ListItem>Discoloration/Stains</asp:ListItem>
                                            <asp:ListItem>Leak</asp:ListItem>
                                            <asp:ListItem>Torn Mesh</asp:ListItem>
                                            <asp:ListItem>Cut String</asp:ListItem>
                                            <asp:ListItem>Stuck-up</asp:ListItem>
                                        </asp:CheckBoxList>
                                        <asp:TextBox runat="server" ID="tboxOtherConcern" placeholder="Other concern" CssClass="form-control"></asp:TextBox>
                                        <br />
                                        <asp:LinkButton ID="LinkButton7" CssClass="btn btn-primary" OnClick="LinkButton7_Click" runat="server">submit concern</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br />
                        <span style="font-size: large">Concern</span>
                        <asp:TextBox ID="concern" CssClass="form-control" placeholder="Concern" runat="server" Rows="6" TextMode="MultiLine"></asp:TextBox>
                        <br />
                        <span style="font-size: large">Conversation</span>
                        <asp:TextBox ID="conversation" CssClass="form-control" placeholder="Conversation" runat="server" Rows="6" TextMode="MultiLine"></asp:TextBox>
                    </div>
                </div>
            </div>
            <br />
            <br />
            <asp:Button ID="Button1" ValidationGroup="val1" runat="server" CssClass="btn btn-success" Text="Button" OnClick="Button1_Click" />
            <br />
            <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="val1" CssClass="alert alert-danger" runat="server" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="date is required" ValidationGroup="val1" ControlToValidate="calldate"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="calldate" Operator="DataTypeCheck" ValidationGroup="val1" Type="Date" ErrorMessage="invalid call-in date"></asp:CompareValidator>
        </ContentTemplate>
    </asp:UpdatePanel>


</asp:Content>

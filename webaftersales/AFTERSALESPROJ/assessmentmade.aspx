<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="assessmentmade.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.assessmentmade" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Assessment</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Assessment</strong></h3>
        <div class="navbar-right">
            <asp:HyperLink ID="HyperLink1" CssClass="btn btn-default" NavigateUrl="~/AFTERSALESPROJ/reportPage.aspx" runat="server" Text="back"></asp:HyperLink>
        </div>
    </div>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <asp:LinkButton ID="LinkButton3" runat="server" CssClass="btn btn-default" PostBackUrl="~/AFTERSALESPROJ/assessmentPage.aspx" OnClick="LinkButton3_Click">Import</asp:LinkButton><br />
    <h4>
    <asp:Label ID="lblkno" runat="server" Text="Label"></asp:Label>&nbsp;
    <asp:Label ID="lbllocation" runat="server" Text="Label"></asp:Label>&nbsp;assessment
        </h4>
   
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

            <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
                <asp:GridView ID="GridView1" CssClass="table" AutoGenerateColumns="False" AllowPaging="True" runat="server" PageSize="5" OnRowCommand="GridView1_RowCommand" OnPageIndexChanging="GridView1_PageIndexChanging" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="editbtn" CommandName="myedit" runat="server">Edit</asp:LinkButton>
                                <asp:LinkButton ID="deletebtn" CommandName="mydelete" OnClientClick="return confirm('delete this record?')" runat="server">Delete</asp:LinkButton>
                                <asp:LinkButton ID="savebtn" Visible="false" CommandName="mysave" runat="server">Update</asp:LinkButton>
                                <asp:LinkButton ID="cancelbtn" Visible="false" CommandName="mycancel" runat="server">Cancel</asp:LinkButton>

                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description">
                            <ItemTemplate>
                                <asp:Label ID="idlbl" runat="server" Visible="false" Text='<%# Bind("ID") %>'></asp:Label>
                                <asp:Label ID="Label2" runat="server" Visible="false" Text='<%# Bind("REPORTID") %>'></asp:Label>
                                <asp:Label ID="descriptionlbl" runat="server" Text='<%# Bind("DESCRIPTION") %>'></asp:Label>
                                <asp:TextBox ID="descriptiontbox" TextMode="MultiLine" Rows="10" Width="400" Visible="false" Text='<%# Eval("DESCRIPTION") %>' runat="server"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Assessment">
                            <ItemTemplate>
                                <asp:Label ID="assessmentlbl" runat="server" Text='<%# Bind("ASSESSMENT") %>'></asp:Label>
                                <asp:TextBox ID="assessmenttbox" Visible="false" TextMode="MultiLine" Width="400" Rows="10" Text='<%# Eval("ASSESSMENT") %>' CssClass="form-control" runat="server"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                    <PagerSettings PageButtonCount="8" />
                    <PagerStyle CssClass="GridPager" HorizontalAlign="Left" BackColor="#CCCCCC" ForeColor="Black" />
                    <EmptyDataTemplate>
                        <div class="alert alert-danger">
                            <h2><strong>Empty Table!</strong>
                                <small>0 result found</small>
                            </h2>
                        </div>
                    </EmptyDataTemplate>
                    <RowStyle BackColor="White" Wrap="False" />
                
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#808080" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#383838" />
                </asp:GridView>
            </asp:Panel>

        </ContentTemplate>
    </asp:UpdatePanel>

    <div class="well">
        <h3>New record</h3>
        Description<br />
        <asp:TextBox ID="newdescriptiontbox" CssClass="form-control" runat="server"></asp:TextBox><br />
        Assessment<br />
        <asp:TextBox ID="newassessmenttbox" TextMode="MultiLine" Rows="10" CssClass="form-control" runat="server"></asp:TextBox><br />
        <asp:Button ID="newbtn" CssClass="btn btn-primary" runat="server" Text="add" OnClick="newbtn_Click" />
    </div>
</asp:Content>

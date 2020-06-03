<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="joborderapproval.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.joborderapproval" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Job Order Approval</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>JO Approval</strong></h3>
        <div class="input-group">
            <asp:TextBox ID="searchkey" CssClass="form-control" runat="server"></asp:TextBox>
            <div class="input-group-btn">
                <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-default"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
            </div>
        </div>
    </div>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <asp:GridView ID="GridView1" runat="server" GridLines="None" AllowPaging="True" AutoGenerateColumns="False" OnPageIndexChanging="GridView1_PageIndexChanging">
        <Columns>
            <asp:TemplateField>
               <ItemTemplate>
                   <div class="panel panel-primary">
                       <div class="panel-heading">
                             <asp:Label ID="lblid" runat="server" Visible="false" Text='<%# Bind("ID") %>'></asp:Label>
                           <asp:Label ID="Label1" runat="server" Text='<%# Bind("CIN") %>'></asp:Label>
                       </div>
                       <div class="panel-body">
                              <strong>
                                <asp:LinkButton ID="projectlbl" CommandName="myquotation"
                                    Font-Size="X-Large" runat="server" Text='<%# Bind("PROJECT") %>'></asp:LinkButton>
                            </strong>
                            <br />
                            <asp:Label ID="addresslbl" Font-Size="15px" runat="server" Text='<%# Bind("ADDRESS") %>'></asp:Label>
                            <br />
                            <asp:Label ID="lbljo" CssClass="text-muted" runat="server" Text='<%# Bind("JO") %>'></asp:Label>
                            <br />
                            <asp:Label ID="datelbl" Font-Size="XX-Large" runat="server" Text='<%# Bind("requested") %>'></asp:Label><br />
                           <asp:LinkButton ID="LinkButton2" CssClass="btn btn-success" runat="server">Approve</asp:LinkButton>
                           <asp:LinkButton ID="LinkButton3" CssClass="btn btn-danger" runat="server">Disapprove</asp:LinkButton>
                       </div>
                       <div class="panel-footer">

                       </div>
                   </div>
               </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>
            <div class="alert alert-danger">
                <h2><strong>Empty Table!</strong>
                    <small>0 result found</small>
                </h2>
            </div>
        </EmptyDataTemplate>
        <PagerSettings PageButtonCount="8" />
        <PagerStyle CssClass="GridPager" HorizontalAlign="Left" />
    </asp:GridView>
</asp:Content>

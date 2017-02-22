﻿<?xml version="1.0" encoding="UTF-8" ?>
<!-- Character sheet with fancy blocks for teh modularity-->
<!-- Created by AngelForest -->
<!-- Prototype by Adam Schmidt -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
	<xsl:output method="html" indent="yes" version="4.0"/>
	<xsl:include href="xt.PreserveLineBreaks.xslt"/>
	<xsl:include href="xt.TitleName.xslt"/>

	<xsl:template match="/characters/character">
		<xsl:variable name="TitleName">
			<xsl:call-template name="TitleName">
				<xsl:with-param name="name" select="name"/>
				<xsl:with-param name="alias" select="alias"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">]]></xsl:text>
		<html>
			<head>
				<meta http-equiv="x-ua-compatible" content="IE=Edge"/>
				<title><xsl:value-of select="$TitleName" /></title>
				<style type="text/css">
					*
					{
					font-family: Arial, Helvetica, sans-serif;
					font-size: 12px;
					vertical-align: top;
					}
					hr
					{
					color: lightgrey;
					height: 1px;
					margin-left: 2px;
					margin-right: 2px;
					}
					ul
					{
					margin-top: 0px;
					margin-bottom: 0px;
					margin-left: 20px;
					padding-left: 0px;
					list-style-type: none;
					}
					li
					{
					margin-top: 2px;
					}
					.fill33
					{
					width: 33%;
					}
					.fill66
					{
					width: 66%;
					}
					{
					.fill100
					width: 100%;
					}
					table.stats
					{
					border-style: solid;
					border-width: 1px;
					border-color: grey;
					width: 100%;
					border-collapse: collapse;
					}
					table.stats td
					{
					padding: 2px;
					}
					table.stats .bigheader
					{
					color: white;
					background-color: grey;
					font-weight: normal;
					font-variant: small-caps;
					font-size: 110%;
					text-align: center;
					padding-top: 1px;
					padding-bottom: 2px;
					}
					tr:nth-child(odd) {
					background: #eee
					}
					.smallheader
					{
					color: grey;
					}
					strong
					{
					font-size: 105%;
					}
					@media screen
					{
					.page_breaker_off, .page_breaker_on
					{
					display: initial;
					text-align: left;
					}
					.page_breaker_off td, .page_breaker_on td
					{
					border-style: solid;
					border-width: 1px;
					border-color: lightgrey;
					}
					}
					@media print
					{
					*
					{
					font-size: 10px;
					}
					.page_breaker_off
					{
					page-break-before: auto;
					display: none;
					}
					.page_breaker_on
					{
					page-break-before: always;
					display: none;
					}
					.noprint
					{
					display: none;
					}
					}
				</style>
			
				<style type="text/css" id="style_colored_headers">
					table.general {border-color: #6a6f29;}
					table.general .bigheader {background-color: #6a6f29;}
					table.general hr {color: #6a6f29;}
					table.armory {border-color: #9e2121;}
					table.armory .bigheader {background-color: #9e2121;}
					table.armory hr {color: #9e2121;}
					table.machine {border-color: #512b1b;}
					table.machine .bigheader {background-color: #512b1b;}
					table.machine hr {color: #512b1b;}
					table.magic {border-color: #00afef;}
					table.magic .bigheader {background-color: #00afef;}
					table.magic hr {color: #00afef;}
					table.matrix {border-color: #eb7907;}
					table.matrix .bigheader {background-color: #eb7907;}
					table.matrix hr {color: #eb7907;}
					table.gear {border-color: #92509e;}
					table.gear .bigheader {background-color: #92509e;}
					table.gear hr {color: #92509e;}
					table.description {border-color: #00693b;}
					table.description .bigheader {background-color: #00693b;}
					table.description hr {color: #00693b;}
				</style>
			
				<!-- btw, ie version is about 6 and this shit doesn't support normal DOM methods -->
				<script type="text/javascript">
					<xsl:text>
						function toggle_page_breaker(breaker) {
							if (breaker.className == 'page_breaker_off') {
								breaker.className = 'page_breaker_on';
								breaker.getElementsByTagName('span')[0].innerHTML = 'ON';
							}
							else {
								breaker.className = 'page_breaker_off';
								breaker.getElementsByTagName('span')[0].innerHTML = 'OFF';						
							}
						}
						
						function toggle_colors() {
							var ss = document.getElementById('style_colored_headers');
							ss.disabled = !ss.disabled;
						}
					</xsl:text>
				</script>
			</head>
			
			<body>
				<table id="maintable">
					<tr>
						<td class="fill100 noprint">
							<button onClick="toggle_colors();">Choisir Couleurs</button>
						</td>
					</tr>
					<tr>
						<td class="fill33">
							<xsl:call-template name="print_personal_data" />
						</td>
						<td class="fill33">
							<xsl:call-template name="print_attributes" />
						</td>
						<td class="fill33">
							<xsl:call-template name="print_mugshot_and_priorities" />
						</td>
					</tr>
					<xsl:call-template name="page_breaker" />
					<tr>
						<td class="fill66" colspan="2">
							<xsl:call-template name="print_active_skills" />
						</td>
						<td class="fill33">
							<xsl:call-template name="print_knowledge_skills" />
						</td>
					</tr>
					<xsl:call-template name="page_breaker" />
					<tr>
						<xsl:choose>
							<xsl:when test="count(qualities/quality) &gt; count(contacts/contact) or count(contacts/contact) &lt; 4">
								<td class="fill66" colspan="2">
									<xsl:call-template name="print_qualities">
										<xsl:with-param name="double_size" select="true()" />
									</xsl:call-template>
								</td>
								<td class="fill33">
									<xsl:call-template name="print_contacts">
										<xsl:with-param name="double_size" select="false()" />
									</xsl:call-template>
								</td>
							</xsl:when>
							<xsl:otherwise>
								<td class="fill66" colspan="2">
									<xsl:call-template name="print_contacts">
										<xsl:with-param name="double_size" select="true()" />
									</xsl:call-template>
								</td>
								<td class="fill33">
									<xsl:call-template name="print_qualities">
										<xsl:with-param name="double_size" select="false()" />
									</xsl:call-template>
								</td>
							</xsl:otherwise>
						</xsl:choose>
					</tr>
					<xsl:call-template name="page_breaker" />
					<tr>
						<td class="fill66" colspan="2">
							<xsl:call-template name="print_ranged_weapons" />
							<br />
							<xsl:call-template name="print_melee_weapons" />
						</td>
						<td class="fill33">
							<xsl:call-template name="print_armor" />
							<br />
							<xsl:call-template name="print_martial_arts" />
						</td>
					</tr>
					<xsl:call-template name="page_breaker" />
					<tr>
						<td class="fill66" colspan="2">
							<xsl:call-template name="print_vehicles" />
							<br />
							<xsl:call-template name="print_matrix_devices" />
						</td>
						<td class="fill33">
							<xsl:call-template name="print_implants" />
						</td>
					</tr>
					<xsl:if test="resenabled='True'">
						<xsl:call-template name="page_breaker" />
						<tr>
							<td class="fill66" colspan="2">
								<xsl:call-template name="print_sprites" />
							</td>
							<td class="fill33">
								<xsl:call-template name="print_complex_forms" />
								<br />
								<xsl:call-template name="print_submersion" />
							</td>
						</tr>
					</xsl:if>
          <xsl:if test="depenabled='True'">
            <xsl:call-template name="page_breaker" />
            <tr>
              <td class="fill100">
                <xsl:call-template name="print_ai_programs" />
              </td>
            </tr>
          </xsl:if>
					<xsl:if test="magenabled = 'True'">
						<xsl:call-template name="page_breaker" />
						<xsl:choose>
							<!--simplified layour for adepts-->
							<xsl:when test="qualities/quality[name='Adept']">
								<td class="fill33">
									<xsl:call-template name="print_magic" />
									<br />
									<xsl:call-template name="print_foci" />
								</td>
								<td class="fill33">
									<xsl:call-template name="print_adept_powers" />
								</td>
								<td class="fill33">
									<xsl:call-template name="print_initiation" />
								</td>
							</xsl:when>
							<!--everyone else usually have many speels and/or spirits, so we move other tabs to the right-->
							<xsl:otherwise>
								<tr>
									<td class="fill66" colspan="2">
										<xsl:call-template name="print_spells" />
										<br />
										<xsl:call-template name="print_spirits" />
									</td>
									<td class="fill33">
										<xsl:call-template name="print_magic" />
										<br />
										<xsl:if test="qualities/quality[name='Mystic Adept']">
											<xsl:call-template name="print_adept_powers" />
											<br />
										</xsl:if>
										<xsl:call-template name="print_foci" />
										<br />
										<xsl:call-template name="print_initiation" />
									</td>
								</tr>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					<xsl:call-template name="page_breaker" />
					<tr>
						<td class="fill66" colspan="2">
							<xsl:call-template name="print_other_gear" />
						</td>
						<td class="fill33">
							<xsl:call-template name="print_ids" />
							<br />
							<xsl:call-template name="print_lifestyle" />
						</td>
					</tr>
					<xsl:call-template name="page_breaker" />
					<tr>
						<td class="fill100" colspan="3">
							<xsl:call-template name="print_description" />
						</td>
					</tr>
				</table>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template name="print_personal_data">
		<table class="stats general">
			<tr><td colspan="4"><div class="bigheader">[Données Personnelles]</div></td></tr>
			<tr><td>Nom</td><td colspan="3"><strong><xsl:value-of select="name" /></strong></td></tr>
			<tr><td>Pseudo</td><td colspan="3"><strong><xsl:value-of select="alias" /></strong></td></tr>
			<tr>
				<td>Métatype</td>
				<td colspan="3">
					<strong>
						<xsl:value-of select="metatype" />
						<xsl:if test="metavariant != ''"> (<xsl:value-of select="metavariant" />)</xsl:if>
					</strong>
				</td>
			</tr>
			<tr>
				<td>Sexe</td><td><strong><xsl:value-of select="sex" /></strong></td>
				<xsl:choose>
					<xsl:when test="qualities/quality[name='Mystic Adept']"><td>Spéciale</td><td><strong>Adepte Mystique</strong></td></xsl:when>
					<xsl:when test="qualities/quality[name='Adept']"><td>Spéciale</td><td><strong>Adepte</strong></td></xsl:when>
					<xsl:when test="qualities/quality[name='Aspected Magician']"><td>Spéciale</td><td><strong>Magicien Spécialisé</strong></td></xsl:when>
					<xsl:when test="qualities/quality[name='Magician']"><td>Spéciale</td><td><strong>Magicien</strong></td></xsl:when>
					<xsl:when test="qualities/quality[name='Technomancer']"><td>Spéciale</td><td><strong>Technomancien</strong></td></xsl:when>
				</xsl:choose>
			</tr>
			<tr><td>Age</td><td><strong><xsl:value-of select="age" /></strong></td> <td>Peau</td><td><strong><xsl:value-of select="skin" /></strong></td></tr>
			<tr><td>Cheveux</td><td><strong><xsl:value-of select="hair" /></strong></td> <td>Yeux</td><td><strong><xsl:value-of select="eyes" /></strong></td></tr>
			<tr><td>Taille</td><td><strong><xsl:value-of select="height" /></strong></td> <td>Poids</td><td><strong><xsl:value-of select="weight" /></strong></td></tr>
			<tr><td colspan="4"><hr /></td></tr>
			<tr><td>Karma</td><td><strong><xsl:value-of select="karma" /></strong></td> <td>Nuyen</td><td><strong><xsl:value-of select="nuyen" /> &#165;</strong></td></tr>
			<tr><td>Crédibilité</td><td><strong><xsl:value-of select="totalstreetcred" /></strong></td> <td>Karma Total</td><td><strong><xsl:value-of select="totalkarma" /></strong></td></tr>
			<tr><td>Rumeur</td><td><strong><xsl:value-of select="totalnotoriety" /></strong></td> <td>Renommée</td><td><strong><xsl:value-of select="totalpublicawareness" /></strong></td></tr>
			<tr><td colspan="4"><hr /></td></tr>
			<tr><td>Sang-Froid</td><td><strong><xsl:value-of select="composure" /></strong></td> <td>Jaugé les Intentions</td><td><strong><xsl:value-of select="judgeintentions" /></strong></td></tr>
			<tr><td>Mémoire</td><td><strong><xsl:value-of select="memory" /></strong></td> <td>Soulever/Transporter</td><td><strong><xsl:value-of select="liftandcarry" /></strong></td></tr>
			<tr><td>Mouvement</td><td><strong><xsl:value-of select="movement" /></strong></td> <td>Souler/Transporter Poids</td><td><strong><xsl:value-of select="liftweight" />/<xsl:value-of select="carryweight" /></strong></td></tr>
			<tr><td colspan="4"><hr /></td></tr>
			<tr><td>Physique</td><td><strong><xsl:value-of select="limitphysical" /></strong></td> <td>Mentale</td><td><strong><xsl:value-of select="limitmental" /></strong></td></tr>
			<tr><td>Sociale</td><td><strong><xsl:value-of select="limitsocial" /></strong></td> <td>Astrale</td><td><strong><xsl:value-of select="limitastral" /></strong></td></tr>
		</table>
	</xsl:template>
	
	<xsl:template name="print_attributes">
		<table class="stats general">
			<tr><td colspan="4"><div class="bigheader">[Attributs]</div></td></tr>
			<tr>
				<td>Constitution</td><td><strong><xsl:value-of select="attributes/attribute[name = 'BOD']/base" />
									<xsl:if test="attributes/attribute[name = 'BOD']/total != attributes/attribute[name = 'BOD']/base">
										(<xsl:value-of select="attributes/attribute[name = 'BOD']/total" />)
									</xsl:if></strong></td>
				<td>Volonté</td><td><strong><xsl:value-of select="attributes/attribute[name = 'WIL']/base" />
									<xsl:if test="attributes/attribute[name = 'WIL']/total != attributes/attribute[name = 'WIL']/base">
										(<xsl:value-of select="attributes/attribute[name = 'WIL']/total" />)
									</xsl:if></strong></td>
			</tr>
			<tr>
				<td>Agilité</td><td><strong><xsl:value-of select="attributes/attribute[name = 'AGI']/base" />
									<xsl:if test="attributes/attribute[name = 'AGI']/total != attributes/attribute[name = 'AGI']/base">
										(<xsl:value-of select="attributes/attribute[name = 'AGI']/total" />)
									</xsl:if></strong></td>
				<td>Logique</td><td><strong><xsl:value-of select="attributes/attribute[name = 'LOG']/base" />
									<xsl:if test="attributes/attribute[name = 'LOG']/total != attributes/attribute[name = 'LOG']/base">
										(<xsl:value-of select="attributes/attribute[name = 'LOG']/total" />)
									</xsl:if></strong></td>
			</tr>
			<tr>
				<td>Réaction</td><td><strong><xsl:value-of select="attributes/attribute[name = 'REA']/base" />
									<xsl:if test="attributes/attribute[name = 'REA']/total != attributes/attribute[name = 'REA']/base">
										(<xsl:value-of select="attributes/attribute[name = 'REA']/total" />)
									</xsl:if></strong></td>
				<td>Intuition</td><td><strong><xsl:value-of select="attributes/attribute[name = 'INT']/base" />
									<xsl:if test="attributes/attribute[name = 'INT']/total != attributes/attribute[name = 'INT']/base">
										(<xsl:value-of select="attributes/attribute[name = 'INT']/total" />)
									</xsl:if></strong></td>
			</tr>
			<tr>
				<td>Force</td><td><strong><xsl:value-of select="attributes/attribute[name = 'STR']/base" />
									<xsl:if test="attributes/attribute[name = 'STR']/total != attributes/attribute[name = 'STR']/base">
										(<xsl:value-of select="attributes/attribute[name = 'STR']/total" />)
									</xsl:if></strong></td>
				<td>Charisme</td><td><strong><xsl:value-of select="attributes/attribute[name = 'CHA']/base" />
									<xsl:if test="attributes/attribute[name = 'CHA']/total != attributes/attribute[name = 'CHA']/base">
										(<xsl:value-of select="attributes/attribute[name = 'CHA']/total" />)
									</xsl:if></strong></td>
			</tr>
			<tr>
				<td>Chance</td><td><strong><xsl:value-of select="attributes/attribute[name = 'EDG']/base" />
									<xsl:if test="attributes/attribute[name = 'EDG']/total != attributes/attribute[name = 'EDG']/base">
										(<xsl:value-of select="attributes/attribute[name = 'EDG']/total" />)
									</xsl:if></strong></td>
				<td>Essence</td><td><strong><xsl:value-of select="attributes/attribute[name = 'ESS']/base" /></strong></td>
			</tr>
			<xsl:if test="magenabled = 'True'">
				<tr><td>Magie</td><td><strong><xsl:value-of select="attributes/attribute[name = 'MAG']/base" />
										<xsl:if test="attributes/attribute[name = 'MAG']/total != attributes/attribute[name = 'MAG']/base">
											(<xsl:value-of select="attributes/attribute[name = 'MAG']/total" />)
										</xsl:if></strong></td><td colspan="2" /></tr>
			</xsl:if>
			<xsl:if test="resenabled = 'True'">
				<tr><td>Résonance</td><td><strong><xsl:value-of select="attributes/attribute[name = 'RES']/base" />
										<xsl:if test="attributes/attribute[name = 'RES']/total != attributes/attribute[name = 'RES']/base">
											(<xsl:value-of select="attributes/attribute[name = 'RES']/total" />)
										</xsl:if></strong></td><td colspan="2" /></tr>
			</xsl:if>
			<tr><td colspan="4"><hr /></td></tr>
            <tr><td colspan="2">Initiative</td><td colspan="2"><strong><xsl:value-of select="init" /></strong></td></tr>
            <tr><td colspan="2">Initiative Astrale</td><td colspan="2"><strong><xsl:value-of select="astralinit" /></strong></td></tr>
            <tr><td colspan="2">Initiative Interfacé</td><td colspan="2"><strong><xsl:value-of select="riggerinit" /></strong></td></tr>
            <tr><td colspan="2">Initiative RA</td><td colspan="2"><strong><xsl:value-of select="matrixarinit" /></strong></td></tr>
            <tr><td colspan="2">Initiative Cold Sim</td><td colspan="2"><strong><xsl:value-of select="matrixcoldinit" /></strong></td></tr>
            <tr><td colspan="2">Initiative Hot Sim</td><td colspan="2"><strong><xsl:value-of select="matrixhotinit" /></strong></td></tr>
            <tr><td colspan="4"><hr /></td></tr>
            <tr><td colspan="2">MC Physique</td><td colspan="2"><strong><xsl:value-of select="physicalcm" /></strong></td></tr>
            <tr><td colspan="2">Surplus</td><td colspan="2"><strong><xsl:value-of select="cmoverflow - 1"/></strong></td></tr>
            <tr><td colspan="2">MC Etourdissant</td><td colspan="2"><strong><xsl:value-of select="stuncm" /></strong></td></tr>
		</table>
	</xsl:template>
	
	<xsl:template name="print_mugshot_and_priorities">
		<table class="stats general">
			<tr><td colspan="2"><div class="bigheader">[Portrait]</div></td></tr>
			<tr><td colspan="2" style="text-align:center;">
				<xsl:if test="mainmugshotbase64 != ''">
					<img src="data:image/png;base64,{mainmugshotbase64}" />
				</xsl:if>
			</td></tr>
			<xsl:if test="prioritymetatype != ''">
				<tr><td colspan="2"><div class="bigheader">[Priorités]</div></td></tr>
                        <tr><td>Métatype</td><td><strong><xsl:value-of select="prioritymetatype" /></strong></td></tr>
                        <tr><td>Attributs</td><td><strong><xsl:value-of select="priorityattributes" /></strong></td></tr>
                        <tr><td>Spéciale</td><td><strong><xsl:value-of select="priorityspecial" /></strong></td></tr>
                        <tr><td>Compétences</td><td><strong><xsl:value-of select="priorityskills" /></strong></td></tr>
                        <tr><td>Ressources</td><td><strong><xsl:value-of select="priorityresources" /></strong></td></tr>
			</xsl:if>
		</table>
	</xsl:template>
	
	<xsl:template name="print_active_skills">
		<table class="stats general">
			<tr><td colspan="2"><div class="bigheader">[Compétences Actives]</div></td></tr>
			<tr>
				<td style="width:50%;">
					<table style="width:100%; border-collapse: collapse;">
						<xsl:call-template name="print_half_active_skills">
							<xsl:with-param name="condition" select="true()" />
						</xsl:call-template>
					</table>
				</td>
				<td style="width:50%;">
					<table style="width:100%; border-collapse: collapse;">
						<xsl:call-template name="print_half_active_skills">
							<xsl:with-param name="condition" select="false()" />
						</xsl:call-template>
					</table>
				</td>
			</tr>
		</table>
	</xsl:template>
	
	<xsl:template name="print_half_active_skills">
		<xsl:param name="condition" />
		
		<xsl:variable name="sorted_skills">
			<xsl:for-each select="skills/skill[knowledge = 'False' and (rating &gt; 0 or total &gt; 0)]">
				<xsl:sort select="skillcategory" />
				<xsl:sort select="name" />
				
				<xsl:copy-of select="current()"/>
			</xsl:for-each>
		</xsl:variable>
		
		<xsl:variable name="skills_half_count" select="ceiling(count(msxsl:node-set($sorted_skills)/skill) div 2) + 1" />
		
		<tr class="smallheader"><td>Compétence</td><td>Ind</td><td>Réserve</td></tr>
		<xsl:for-each select="msxsl:node-set($sorted_skills)/skill">
			<xsl:sort select="skillcategory" />
			<xsl:sort select="name" />
			
			<xsl:if test="(position() &lt; $skills_half_count)=$condition">
				<xsl:if test="skillcategory != preceding-sibling::skill[1]/skillcategory or position()=1">
					<tr><td colspan="3"><strong><u><xsl:value-of select="skillcategory" /> Compétences</u></strong></td></tr>
				</xsl:if>
				
				<tr>
					<xsl:call-template name="make_grey_lines" />
					<td>
						<xsl:value-of select="name" />
						<xsl:if test="spec!=''">
							(<xsl:value-of select="spec" />)
						</xsl:if>
						<span style="color:grey;"><xsl:text> </xsl:text><xsl:value-of select="displayattribute" /></span>
					</td>
					<td><xsl:value-of select="rating" /></td>
					<td>
						<xsl:value-of select="total" />
						<xsl:if test="spec != '' and exotic = 'False'">
							(<xsl:value-of select="specializedrating" />)
						</xsl:if>
					</td>
				</tr>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="print_knowledge_skills">
		<table class="stats general">
			<xsl:variable name="sorted_skills">
				<xsl:for-each select="skills/skill[knowledge = 'True']">
					<xsl:sort select="skillcategory" />
					<xsl:sort select="name" />
					
					<xsl:copy-of select="current()"/>
				</xsl:for-each>
			</xsl:variable>
		
			<tr><td colspan="3"><div class="bigheader">[Compétences de Connaissances]</div></td></tr>
			<tr class="smallheader"><td>Compétence</td><td>Ind</td><td>Réserve</td></tr>
			<xsl:for-each select="msxsl:node-set($sorted_skills)/skill">
				
				<xsl:if test="skillcategory!=preceding-sibling::skill[1]/skillcategory or position()=1">
					<tr><td colspan="3"><strong><u><xsl:value-of select="skillcategory" /></u></strong></td></tr>
				</xsl:if>
				<tr>
					<xsl:call-template name="make_grey_lines" />
					<td>
						<xsl:value-of select="name" />
						<xsl:if test="spec!=''">
							(<xsl:value-of select="spec" />)
						</xsl:if>	
					</td>
					<xsl:choose>
						<xsl:when test="skillcategory_english='Language' and rating=0">
							<td colspan="2">Maternelle</td>
						</xsl:when>
						<xsl:otherwise>
							<td><xsl:value-of select="rating" /></td>
							<td>
								<xsl:value-of select="total" />
								<xsl:if test="spec != ''">
									(<xsl:value-of select="specializedrating" />)
								</xsl:if>
							</td>
						</xsl:otherwise>
					</xsl:choose>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>
	
	<xsl:template name="print_qualities">
		<xsl:param name="double_size" />
	
		<table class="stats general">
			<xsl:choose>
				<xsl:when test="$double_size">
					<tr><td colspan="2"><div class="bigheader">[Traits]</div></td></tr>
					<tr class="smallheader"><td>Positif</td><td>Negatif</td></tr>
					<tr>
						<td style="width:50%;">
							<xsl:call-template name="print_qualities_by_type">
								<xsl:with-param name="quality_type" select="'Positive'" />
							</xsl:call-template>
						</td>
						<td style="width:50%;">
							<xsl:call-template name="print_qualities_by_type">
								<xsl:with-param name="quality_type" select="'Negative'" />
							</xsl:call-template>
						</td>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<tr><td><div class="bigheader">[Traits]</div></td></tr>
					<tr class="smallheader"><td>Positif</td></tr>
					<tr><td>
						<xsl:call-template name="print_qualities_by_type">
							<xsl:with-param name="quality_type" select="'Positive'" />
						</xsl:call-template>
					</td></tr>
					<tr class="smallheader"><td>Negatif</td></tr>
					<tr><td>
						<xsl:call-template name="print_qualities_by_type">
							<xsl:with-param name="quality_type" select="'Negative'" />
						</xsl:call-template>
					</td></tr>
				</xsl:otherwise>
			</xsl:choose>
		</table>
	</xsl:template>
	
	<xsl:template name="print_qualities_by_type">
		<xsl:param name="quality_type" />
		
		<ul style="margin-left:0px;">
			<xsl:for-each select="qualities/quality[qualitytype_english=$quality_type]">
				<xsl:sort select="qualitysource='Metatype'" order='descending' />
				<xsl:sort select="name" />
		
				<li>
					<xsl:if test="qualitysource='Metatype'">
						<xsl:attribute name="style">color:grey;</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="name" />
					<xsl:if test="extra!=''"> (<xsl:value-of select="extra" />)</xsl:if> 
					<xsl:call-template name="print_source_page" />
					<xsl:call-template name="print_notes" />
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>
	
	<xsl:template name="print_contacts">
		<xsl:param name="double_size" />
		
		<xsl:variable name="sorted_contacts">
			<xsl:for-each select="contacts/contact">
				<xsl:sort select="name" />
				
				<xsl:copy-of select="current()" />
			</xsl:for-each>
		</xsl:variable>
	
		<table class="stats general">
			<xsl:choose>
				<xsl:when test="$double_size">
					<tr><td colspan="2"><div class="bigheader">[Contacts]</div></td></tr>
					<tr>
						<td style="width:50%;">
							<table style="width:100%; border-collapse: collapse;">
								<tr class="smallheader"><td>Contact</td><td>Localisation</td><td>I/L</td></tr>
								<xsl:call-template name="print_half_contacts">
									<xsl:with-param name="contacts" select="$sorted_contacts" />
									<xsl:with-param name="condition" select="true()" />
								</xsl:call-template>
							</table>
						</td>
						<td style="width:50%;">
							<table style="width:100%; border-collapse: collapse;">
								<tr class="smallheader"><td>Contact</td><td>Localisation</td><td>I/L</td></tr>
								<xsl:call-template name="print_half_contacts">
									<xsl:with-param name="contacts" select="$sorted_contacts" />
									<xsl:with-param name="condition" select="false()" />
								</xsl:call-template>
							</table>
						</td>
					</tr>
				</xsl:when>
				<xsl:otherwise>		
					<tr><td colspan="3"><div class="bigheader">[Contacts]</div></td></tr>
					<tr class="smallheader"><td>Contact</td><td>Localisation</td><td>I/L</td></tr>
					<xsl:call-template name="print_half_contacts">
						<xsl:with-param name="contacts" select="$sorted_contacts" />
						<xsl:with-param name="condition" select="true()" />
					</xsl:call-template>
					<xsl:call-template name="print_half_contacts">
						<xsl:with-param name="contacts" select="$sorted_contacts" />
						<xsl:with-param name="condition" select="false()" />
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>			
		</table>
	</xsl:template>
	
	<xsl:template name="print_half_contacts">
		<xsl:param name="contacts" />
		<xsl:param name="condition" />
		
		<xsl:variable name="half_count" select="ceiling(count(msxsl:node-set($contacts)/contact) div 2) + 1" />
		
		<xsl:for-each select="msxsl:node-set($contacts)/contact">
			<xsl:if test="(position() &lt; $half_count)=$condition">
				<tr>
					<xsl:call-template name="make_grey_lines" />
					<td>
						<xsl:value-of select="name" />
						<xsl:if test="role != ''"> (<xsl:value-of select="role" />)</xsl:if>						
					</td>
					<td><xsl:value-of select="location" /></td>
					<td><xsl:value-of select="connection" />/<xsl:value-of select="loyalty" /></td>
				</tr>
				<xsl:if test="notes!=''">
					<tr>
						<xsl:call-template name="make_grey_lines" />
						<td colspan="3">
							<xsl:call-template name="print_notes"><xsl:with-param name="linebreak" select="false()" /></xsl:call-template>
						</td>
					</tr>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="print_ranged_weapons">
		<xsl:variable name="sorted_ranged">
			<xsl:for-each select="weapons/weapon[type='Ranged']">
				<xsl:sort select="location" />
				<xsl:sort select="name" />
				
				<xsl:copy>
					<xsl:if test="../../gears/gear[name=current()/name]">
						<xsl:element name="qty"><xsl:value-of select="../../gears/gear[name=current()/name]/qty" /></xsl:element>
					</xsl:if>
					<xsl:copy-of select="*" />
				</xsl:copy>
			</xsl:for-each>
		</xsl:variable>
		
		<xsl:variable name="sorted_ammunition">
			<xsl:for-each select="gears/gear[category_english='Ammunition']">
				<xsl:sort select="name" />
				
				<xsl:if test="count(../../weapons/weapon[name=current()/name]) = 0">
					<xsl:copy-of select="current()" />
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		
		<xsl:if test="count(msxsl:node-set($sorted_ranged)/*) &gt; 0  or  count(msxsl:node-set($sorted_ammunition)/*) &gt; 0">
			
			<xsl:variable name="need_location" select="count(msxsl:node-set($sorted_ranged)/weapon[location!='']) &gt; 0" />
		
			<table class="stats armory">
				<tr><td colspan="8"><div class="bigheader">[Armes à Distance]</div></td></tr>
				<tr class="smallheader"><td>Arme</td><td>VD</td><td>PA</td><td>Mode</td><td>CR</td><td>Mun</td><td>Acc</td><td>Réserve</td></tr>
		
				<xsl:for-each select="msxsl:node-set($sorted_ranged)/weapon">
					<xsl:if test="$need_location and (position()=1 or location!=preceding-sibling::weapon[1]/location)">
						<tr>
							<td colspan="8">
								<xsl:call-template name="print_location" />
							</td>
						</tr>
					</xsl:if>
					
					<xsl:call-template name="print_ranged_weapon_stats" />
				</xsl:for-each>
				
				<xsl:if test="count(msxsl:node-set($sorted_ammunition)/*) &gt; 0">
					<tr><td colspan="8"><hr /></td></tr>
				
					<xsl:for-each select="msxsl:node-set($sorted_ammunition)/*">
				
						<tr>
							<td>
								<xsl:value-of select="name" />
								<xsl:if test="extra!=''"> (<xsl:value-of select="extra" />)</xsl:if>
								<xsl:if test="qty &gt; 1">
									<xsl:text> x</xsl:text><xsl:value-of select="qty" />
								</xsl:if>
								<xsl:call-template name="print_source_page" />
								<xsl:call-template name="print_notes" />
							</td>
							<td><xsl:value-of select="weaponbonusdamage" /></td>
							<td><xsl:value-of select="weaponbonusap" /></td>
							<td colspan="5"></td>
						</tr>
					</xsl:for-each>
				</xsl:if>
			</table>
			
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="print_ranged_weapon_stats">
		<xsl:param name="is_mount" select="false()" />
	
		<tr>
			<xsl:if test="$is_mount">
				<td rowspan="2">
					<xsl:call-template name="short_mount_name" />
				</td>
			</xsl:if>
			<td rowspan="2">
				<xsl:call-template name="print_nested" />
				<ul>
					<xsl:for-each select="accessories/accessory">
						<xsl:sort select="included" order="descending" />
						<xsl:sort select="name" />
						
						<li><xsl:call-template name="print_nested" /></li>
					</xsl:for-each>
				</ul>
			</td>
			<td><xsl:value-of select="damage" /></td>
			<td><xsl:value-of select="ap" /></td>
			<td><xsl:value-of select="mode" /></td>
			<td><xsl:value-of select="rc" /></td>
			<td><xsl:value-of select="ammo" /></td>
			<td><xsl:value-of select="accuracy" /></td>
			<td><xsl:value-of select="dicepool" /></td>
		</tr>
		<tr>
			<td colspan="7">
				<xsl:if test="ranges/short!='' or ranges/medium!='' or ranges/long!='' or ranges/extreme!=''">
					<table style="border-style:solid;border-width:1px;border-color:lightgrey;">
						<tr><td>Courte</td><td>Moyenne</td><td>Longue</td><td>Extrême</td></tr>
						<tr>
							<td><xsl:value-of select="ranges/short" /></td>
							<td><xsl:value-of select="ranges/medium" /></td>
							<td><xsl:value-of select="ranges/long" /></td>
							<td><xsl:value-of select="ranges/extreme" /></td>	
						</tr>
					</table>
				</xsl:if>
			</td>
		</tr>
		<xsl:if test="count(underbarrel/weapon) &gt; 0">
			<tr><td colspan="8"><ul>
			<xsl:if test="count(underbarrel/weapon[type='Ranged']) &gt; 0">
				<li><table>
					<tr class="smallheader"><td>Arme sous le Canon</td><td>VD</td><td>PA</td><td>Mode</td><td>CR</td><td>Mun</td><td>Acc</td><td>Réserve</td></tr>
					<xsl:for-each select="underbarrel/weapon[type='Ranged']">
						<xsl:sort select="name" />
						<xsl:call-template name="print_ranged_weapon_stats" />
					</xsl:for-each>
				</table></li>
			</xsl:if>
			<xsl:if test="count(underbarrel/weapon[type='Melee']) &gt; 0">
				<li><table>
					<tr class="smallheader"><td>Arme sous le Canon</td><td>VD</td><td>PA</td><td>Allonge</td><td>Acc</td><td>Réserve</td></tr>
					<xsl:for-each select="underbarrel/weapon[type='Melee']">
						<xsl:sort select="name" />
						<xsl:call-template name="print_melee_weapon_stats" />
					</xsl:for-each>
				</table></li>
			</xsl:if>
			</ul></td></tr>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="print_melee_weapons">
		<xsl:variable name="sorted_melee">
			<xsl:for-each select="weapons/weapon[type='Melee']">
				<xsl:sort select="location" />
				<xsl:sort select="name" />
				
				<xsl:copy-of select="current()" />
			</xsl:for-each>
		</xsl:variable>
		
		<xsl:variable name="need_location" select="count(msxsl:node-set($sorted_melee)/weapon[location!='']) &gt; 0" />
	
		<table class="stats armory">
			<tr><td colspan="6"><div class="bigheader">[Armes de Mélée]</div></td></tr>
			<tr class="smallheader"><td>Arme</td><td>VD</td><td>PA</td><td>Allonge</td><td>Acc</td><td>Réserve</td></tr>
			
			<xsl:for-each select="msxsl:node-set($sorted_melee)/weapon">
				<xsl:if test="$need_location and (position()=1 or location!=preceding-sibling::weapon[1]/location)">
					<tr>
						<td colspan="6">
							<xsl:call-template name="print_location" />
						</td>
					</tr>					
				</xsl:if>
			
				<xsl:call-template name="print_melee_weapon_stats" />
			</xsl:for-each>
		</table>
	</xsl:template>
	
	<xsl:template name="print_melee_weapon_stats">
		<xsl:param name="is_mount" select="false()" />
	
		<tr>
			<xsl:if test="$is_mount">
				<td>
					<xsl:call-template name="short_mount_name" />
				</td>
			</xsl:if>
			<td>
				<xsl:value-of select="name" />
				<xsl:call-template name="print_source_page" />
				<xsl:call-template name="print_notes" />
				<ul>
					<xsl:for-each select="accessories/accessory">
						<xsl:sort select="included" order="descending" />
						<xsl:sort select="name" />
					
						<li><xsl:call-template name="print_nested" /></li>
					</xsl:for-each>
				</ul>
			</td>
			<td><xsl:value-of select="damage" /></td>
			<td><xsl:value-of select="ap" /></td>
			<td><xsl:value-of select="reach" /></td>
			<td><xsl:value-of select="accuracy" /></td>
			<td><xsl:value-of select="dicepool" /></td>
		</tr>
	</xsl:template>
	
	<xsl:template name="print_armor">
		<xsl:variable name="sorted_armor">
			<xsl:for-each select="armors/armor">
				<xsl:sort select="location" />
				<xsl:sort select="name" />
				
				<xsl:copy-of select="current()" />
			</xsl:for-each>
		</xsl:variable>
		
		<xsl:variable name="need_location" select="count(msxsl:node-set($sorted_armor)/armor[location!='']) &gt; 0" />
	
		<table class="stats armory">
			<tr><td colspan="3"><div class="bigheader">[Armure]</div></td></tr>
			<tr class="smallheader"><td></td><td>Armure</td><td>Indice</td></tr>
			
			<xsl:for-each select="msxsl:node-set($sorted_armor)/armor">
				<xsl:if test="$need_location and (position()=1 or location!=preceding-sibling::armor[1]/location)">
					<tr>
						<td colspan="3">
							<xsl:call-template name="print_location" />
						</td>
					</tr>
				</xsl:if>
				
				<tr>
					<td>
						<xsl:choose>
							<xsl:when test="equipped='True'"> &#x26AB;</xsl:when>
							<xsl:otherwise> &#x26AA;</xsl:otherwise>
						</xsl:choose>
					</td>
					<td>
					
						<xsl:value-of select="name" />
						<xsl:call-template name="print_source_page" />
						<xsl:call-template name="print_notes" />
						<ul>
							<xsl:for-each select="armormods/armormod|gears/gear">
								<xsl:sort select="included" order="descending" />
								<xsl:sort select="name" />
							
								<li><xsl:call-template name="print_nested" /></li>
							</xsl:for-each>
						</ul>
					</td>
					<td>
						<xsl:value-of select="armor" />
					</td>
				</tr>
			</xsl:for-each>
			
			<tr>
				<td></td>
				<td><strong>Total</strong></td>
				<td><strong><xsl:value-of select="armor" /></strong></td>
			</tr>
		</table>
	</xsl:template>
	
	<xsl:template name="print_martial_arts">
		<xsl:if test="count(martialarts/martialart) &gt; 0">
		
			<table class="stats armory">
				<tr><td><div class="bigheader">[Arts Martiaux]</div></td></tr>
				<tr><td>
					<ul>
						<xsl:for-each select="martialarts/martialart">
							<xsl:sort select="name" />

							<li>
								<xsl:value-of select="name" />
								<xsl:call-template name="print_source_page" />
								<xsl:call-template name="print_notes" />
								<ul>
									<xsl:for-each select="martialartadvantages/martialartadvantage">
										<xsl:sort select="name" />
										<li>
											<xsl:value-of select="name" />
											<xsl:call-template name="print_source_page" />
											<xsl:call-template name="print_notes" />
										</li>
									</xsl:for-each>
								</ul>
							</li>
						</xsl:for-each>
					</ul>
				</td></tr>
			</table>
			
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="print_vehicles">
		<xsl:if test="count(vehicles/vehicle) &gt; 0">
	
			<table class="stats machine">
				<tr><td colspan="2"><div class="bigheader">[Véhicules]</div></td></tr>
				<xsl:for-each select="vehicles/vehicle">
					<xsl:sort select="name" />
					
					<xsl:if test="position()!=1">
						<tr><td colspan="2"><hr /></td></tr>
					</xsl:if>
					
					<tr>
						<td>
							<xsl:value-of select="name" />
							<xsl:call-template name="print_source_page" />
							<xsl:call-template name="print_notes" />
							<ul>
								<xsl:if test="count(mods/mod) &gt; 0">
									<li><strong>Mods</strong></li>
									<xsl:for-each select="mods/mod[not(contains(name, 'Weapon Mount'))]">
										<xsl:sort select="included" order="descending" />
										<xsl:sort select="name" />
									
										<li><xsl:call-template name="print_nested" /></li>
									</xsl:for-each>
								</xsl:if>
								<xsl:if test="count(gears/gear) &gt; 0">
									<li><strong>Equipement</strong></li>
									<xsl:for-each select="gears/gear">
										<xsl:sort select="name" />
										
										<li><xsl:call-template name="print_nested" /></li>
									</xsl:for-each>
								</xsl:if>
							</ul>
						</td>
						<td>
							<table style="width:100%;">
								<tr><td>Maniabilité</td><td><xsl:value-of select="handling" /></td><td>Structure</td><td><xsl:value-of select="body" /></td></tr>
								<tr><td>Accélération</td><td><xsl:value-of select="accel" /></td><td>Blindage</td><td><xsl:value-of select="armor" /></td></tr>
								<tr><td>Vitesse</td><td><xsl:value-of select="speed" /></td><td>Senseur</td><td><xsl:value-of select="sensor" /></td></tr>
								<tr><td>AutoPilote</td><td><xsl:value-of select="pilot" /></td><td>Indice</td><td><xsl:value-of select="devicerating" /></td></tr>
								<tr>
									<td>MC Physique</td><td><xsl:value-of select="physicalcm" /></td>
									<xsl:if test="seats &gt; 0"><td>Places</td><td><xsl:value-of select="seats" /></td></xsl:if>
								</tr>
								<tr><td>MC Matriciel</td><td><xsl:value-of select="8 + ceiling(devicerating div 2)" /></td></tr>
							</table>
						</td>
					</tr>
					
					<xsl:if test="count(mods/mod[contains(name, 'Weapon Mount')]/weapons/weapon[type='Ranged']) &gt; 0">
						<tr>
							<td colspan="2">
								<table>
									<tr class="smallheader"><td>Monture</td><td>Arme</td><td>VD</td><td>PA</td><td>Mode</td><td>CR</td><td>Mun</td><td>Acc</td><td>Réserve</td></tr>
									<xsl:for-each select="mods/mod[contains(name, 'Weapon Mount')]/weapons/weapon[type='Ranged']">
										<xsl:sort select="name" />
									
										<xsl:call-template name="print_ranged_weapon_stats">
											<xsl:with-param name="is_mount" select="true()" />
										</xsl:call-template>
									</xsl:for-each>
								</table>
							</td>
						</tr>
					</xsl:if>
					
					<xsl:if test="count(mods/mod[contains(name, 'Weapon Mount')]/weapons/weapon[type='Melee']) &gt; 0">
						<tr>
							<td colspan="2">
								<table>
									<tr class="smallheader"><td>Monture</td><td>Arme</td><td>VD</td><td>PA</td><td>Allonge</td><td>Acc</td><td>Réserve</td></tr>
									<xsl:for-each select="mods/mod[contains(name, 'Weapon Mount')]/weapons/weapon[type='Melee']">
										<xsl:sort select="name" />
									
										<xsl:call-template name="print_melee_weapon_stats">
											<xsl:with-param name="is_mount" select="true()" />
										</xsl:call-template>
									</xsl:for-each>
								</table>
							</td>
						</tr>
					</xsl:if>			
				</xsl:for-each>
			</table>
			
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="short_mount_name">
		<xsl:choose>
			<xsl:when test="contains(../../name, 'Heavy')"><xsl:text>Renforcé</xsl:text></xsl:when>
			<xsl:otherwise><xsl:text>Standard</xsl:text></xsl:otherwise>
		</xsl:choose>
		<xsl:if test="contains(../../name, 'Manual')">
			<xsl:text>, Manuel</xsl:text>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="print_implants">
		<xsl:if test="count(cyberwares/cyberware) &gt; 0">
	
			<table class="stats machine">
				<tr><td colspan="3"><div class="bigheader">[Implants]</div></td></tr>
				<tr class="smallheader"><td>Implant</td><td>Ess</td><td>Grade</td></tr>
				
				<xsl:for-each select="cyberwares/cyberware">
					<xsl:sort select="name" />
					
					<tr>
						<td>
							<xsl:call-template name="print_imp_nested" />
						</td>
						<td><xsl:value-of select="ess" /></td>
						<td><xsl:value-of select="grade" /></td>
					</tr>
				</xsl:for-each>
			</table>
			
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="print_imp_nested">
		<xsl:choose>
			<!-- Cyberlimb name contains its stats in parenthesis, so I split it to two lines -->
			<xsl:when test="category='Cyberlimb' and contains(name, '(')">
				<xsl:value-of select="substring-before(name, '(')" />
				<xsl:if test="rating &gt; 0"> [R<xsl:value-of select="rating" />]</xsl:if>
				<xsl:call-template name="print_source_page" />
				<br />
				(<xsl:value-of select="substring-after(name, '(')" />
				<xsl:call-template name="print_notes" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="name" />
				<xsl:if test="rating &gt; 0"> [R<xsl:value-of select="rating" />]</xsl:if>
				<xsl:call-template name="print_source_page" />
				<xsl:call-template name="print_notes" />
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="count(children/cyberware) &gt; 0 or count(gears/gear) &gt; 0">
			<ul>
				<xsl:for-each select="children/cyberware">
					<xsl:sort select="name" />
					<li><xsl:call-template name="print_imp_nested" /></li>
				</xsl:for-each>
				<xsl:for-each select="gears/gear">
					<xsl:sort select="name" />
					<li><xsl:call-template name="print_nested" /></li>
				</xsl:for-each>
			</ul>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="print_matrix_devices">
		<xsl:variable name="sorted_devices">
			<xsl:for-each select="//gear[category_english='Commlinks' or category_english='Commlink' or category_english='Cyberdecks' or category_english='Rigger Command Consoles']">
				<xsl:sort select="category" />
				<xsl:sort select="name" />
				
				<xsl:copy-of select="current()" />
			</xsl:for-each>
		</xsl:variable>
	
		<xsl:if test="count(msxsl:node-set($sorted_devices)/*) &gt; 0">
		
			<table class="stats matrix">
				<tr><td colspan="5"><div class="bigheader">[Cyberdeck/Commlink]</div></td></tr>
				<tr class="smallheader"><td>Appareil</td><td>RD</td><td>MC</td><td>A/C/D/F</td><td>Limite Programme</td></tr>
				
				<xsl:for-each select="msxsl:node-set($sorted_devices)/*">
					<xsl:call-template name="print_matrix_device_stats" />
				</xsl:for-each>
			</table>
			
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="print_matrix_device_stats">
		<xsl:variable name="sorted_everything">
			<xsl:for-each select="children/gear[category_english='Specialty Condition']">
				<xsl:sort select="name" />
				
				<xsl:copy>
					<xsl:element name="category_tag">Spécial</xsl:element>
					<xsl:copy-of select="*" />
				</xsl:copy>
			</xsl:for-each>

			<xsl:for-each select="children/gear[category_english='Cyberdeck Modules' or category_english='Electronic Modification']">
				<xsl:sort select="name" />
				
				<xsl:copy>
					<xsl:element name="category_tag">Modifications</xsl:element>
					<xsl:copy-of select="*" />
				</xsl:copy>
			</xsl:for-each>
			
			<xsl:for-each select="children/gear[category_english='Common Programs' or category_english='Hacking Programs' or category_english='Builtin Programs' or category_english='Software']">
				<xsl:sort select="category_english='Builtin Programs'" order="descending"/>
				<xsl:sort select="name" />
				
				<xsl:copy>
					<xsl:element name="category_tag">Programmes</xsl:element>
					<xsl:copy-of select="*" />
				</xsl:copy>
			</xsl:for-each>

			<xsl:for-each select="children/gear[category_english!='Specialty Condition' and category_english!='Cyberdeck Modules' and category_english!='Electronic Modification' and category_english!='Builtin Programs' and category_english!='Common Programs' and category_english!='Hacking Programs' and category_english!='Software']">
				<xsl:sort select="name" />
				
				<xsl:copy>
					<xsl:element name="category_tag">Equipement</xsl:element>
					<xsl:copy-of select="*" />
				</xsl:copy>
			</xsl:for-each>
		</xsl:variable>
	
		<tr>
			<td>
				<xsl:value-of select="name" />
				<xsl:if test="qty &gt; 1"> x<xsl:value-of select="qty" /></xsl:if>
				<xsl:call-template name="print_source_page" />
			</td>
			<td><xsl:value-of select="devicerating" /></td>
			<td><xsl:value-of select="8 + ceiling(devicerating div 2)" /></td>
			<td>
				<xsl:value-of select="attack" />/
				<xsl:value-of select="sleaze" />/
				<xsl:value-of select="dataprocessing" />/
				<xsl:value-of select="firewall" />
			</td>
			<td><xsl:value-of select="processorlimit" /></td>
		</tr>
		<xsl:if test="notes!=''">
			<tr>
				<td colspan="5">
					<xsl:call-template name="print_notes"><xsl:with-param name="linebreak" select="false()" /></xsl:call-template>
				</td>
			</tr>
		</xsl:if>
		<tr>
			<td>
				<ul>
					<xsl:call-template name="print_matrix_device_nested_list_by_half">
						<xsl:with-param name="list" select="$sorted_everything" />
						<xsl:with-param name="condition" select="true()" />
					</xsl:call-template>
				</ul>
			</td>
			<td colspan="4">
				<ul>
					<xsl:call-template name="print_matrix_device_nested_list_by_half">
						<xsl:with-param name="list" select="$sorted_everything" />
						<xsl:with-param name="condition" select="false()" />
					</xsl:call-template>
				</ul>
			</td>
		</tr>
	</xsl:template>
	
	<xsl:template name="print_matrix_device_nested_list_by_half">
		<xsl:param name="list" />
		<xsl:param name="condition" />
		
		<xsl:variable name="list_half_count" select="ceiling(count(msxsl:node-set($list)/*) div 2) + 1" />
		
		<xsl:for-each select="msxsl:node-set($list)/*">
			<xsl:if test="(position() &lt; $list_half_count)=$condition">
			
				<xsl:if test="( category_tag!=preceding-sibling::gear[1]/category_tag or position()=1 ) and category_tag!='Special'">
					<li><strong><xsl:value-of select="category_tag" /></strong></li>
				</xsl:if>
				<li>
					<xsl:if test="category_english='Builtin Programs'">
						<xsl:attribute name="style">color:grey;</xsl:attribute>
					</xsl:if>
					<xsl:call-template name="print_nested" />
				</li>
				
			</xsl:if>
		</xsl:for-each>
		
	</xsl:template>
	
	<xsl:template name="print_sprites">
		<xsl:if test="count(spirits/spirit) &gt; 0">
		
			<table class="stats matrix">
				<tr><td colspan="2"><div class="bigheader">[Sprites]</div></td></tr>
				<xsl:for-each select="spirits/spirit">
					<xsl:sort select="name" />
					<xsl:sort select="crittername" />
				
					<tr>
						<td>
							<xsl:value-of select="name" />
							<xsl:if test="crittername!=''"> (<xsl:value-of select="crittername" />)</xsl:if>
							<xsl:choose>
								<xsl:when test="bound='True'"> (Lié)</xsl:when>
								<xsl:otherwise> (Non Lié)</xsl:otherwise>
							</xsl:choose>
							<xsl:call-template name="print_source_page" />
							<xsl:call-template name="print_notes" />
							<br />
							<table>
								<tr class="smallheader"><td>Compétence</td><td>Réserve</td></tr>
								<xsl:for-each select="skills/skill">
									<tr>
										<td>
											<xsl:value-of select="name" />
											<span style="color:grey; text-transform: uppercase;"><xsl:text> </xsl:text>
												<xsl:choose>
													<xsl:when test="attr=cha">A</xsl:when>
													<xsl:when test="attr=int">C</xsl:when>
													<xsl:when test="attr=log">D</xsl:when>
													<xsl:when test="attr=wil">F</xsl:when>
												</xsl:choose>
											</span>
										</td>
										<td><xsl:value-of select="pool" /></td>
									</tr>
								</xsl:for-each>
							</table>
						</td>
						<td>
							<table style="width:100%;">
								<td>Puissance</td><td><xsl:value-of select="force" /></td><td>Services</td><td><xsl:value-of select="services" /></td>
								<tr><td>Attaque</td><td><xsl:value-of select="spiritattributes/cha" /></td><td>Traitement de Données</td><td><xsl:value-of select="spiritattributes/log" /></td></tr>
								<tr><td>Corruption</td><td><xsl:value-of select="spiritattributes/int" /></td><td>Firewall</td><td><xsl:value-of select="spiritattributes/wil" /></td></tr>
								<tr>
									<td>MC Matriciel</td><td><xsl:value-of select="8 + ceiling(force div 2)" /></td>
									<td>Initiative</td><td><xsl:value-of select="spiritattributes/ini" /><xsl:text>+4d6</xsl:text></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td>
							<ul style="margin-left:5px;">
								<xsl:if test="count(powers/power) &gt; 0">
									<li><strong>Pouvoirs</strong></li>
									<xsl:for-each select="powers/power">
										<li>
											<xsl:value-of select="name" />
											<xsl:call-template name="print_source_page" />
										</li>
									</xsl:for-each>
								</xsl:if>
							</ul>
						</td>
					</tr>
					
					<xsl:if test="position() != last()">
						<tr><td colspan="2"><hr /></td></tr>
					</xsl:if>
				</xsl:for-each>
			</table>
			
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="print_complex_forms">
		<xsl:if test="count(complexforms/complexform) &gt; 0">
	
			<table class="stats matrix">
				<tr><td colspan="4"><div class="bigheader">[Formes Complexes]</div></td></tr>
				<tr class="smallheader"><td>Nom</td><td>Cible</td><td>Durée</td><td>VT</td></tr>
				
				<xsl:for-each select="complexforms/complexform">
					<xsl:sort select="name" />
					
					<tr>
						<td>
							<xsl:value-of select="name" />
							<xsl:if test="extra!=''"> (<xsl:value-of select="extra" />)</xsl:if>
							<xsl:call-template name="print_source_page" />
							<xsl:call-template name="print_notes" />
						</td>
						<td><xsl:value-of select="target" /></td>
						<td><xsl:value-of select="duration" /></td>
						<td><xsl:value-of select="fv" /></td>
					</tr>
				</xsl:for-each>
			</table>
			
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="print_submersion">
		<xsl:if test="submersiongrade &gt; 0">
		
			<table class="stats matrix">
				<tr><td><div class="bigheader">[Submersion]</div></td></tr>
				<tr><td>
					<strong>Grade Submersion <xsl:value-of select="submersiongrade" /></strong>
					<br />
						<strong>Echos</strong>
						<ul>
							<xsl:for-each select="metamagics/metamagic">
								<xsl:sort select="name" />
								
								<li>
									<xsl:value-of select="name" />
									<xsl:call-template name="print_source_page" />
									<xsl:call-template name="print_notes" />
								</li>
							</xsl:for-each>
						</ul>
				</td></tr>
			</table>
			
		</xsl:if>
	</xsl:template>

  <xsl:template name="print_ai_programs">
    <xsl:if test="count(aiprograms/aiprogram) &gt; 0">

      <table class="stats matrix">
        <tr>
          <td colspan="2">
            <div class="bigheader">[Programmes IA et Programmes Avancées]</div>
          </td>
        </tr>
        <tr class="smallheader">
          <td>Nom</td>
          <td>Requires Program</td>
        </tr>

        <xsl:for-each select="aiprograms/aiprogram">
          <xsl:sort select="name" />

          <tr>
            <td>
              <xsl:value-of select="name" />
              <xsl:if test="extra!=''">
                (<xsl:value-of select="extra" />)
              </xsl:if>
              <xsl:call-template name="print_source_page" />
              <xsl:call-template name="print_notes" />
            </td>
            <td>
              <xsl:value-of select="requiresprogram" />
            </td>
          </tr>
        </xsl:for-each>
      </table>

    </xsl:if>
  </xsl:template>
	
	<xsl:template name="print_magic">
		<table class="stats magic">
			<tr><td colspan="4"><div class="bigheader">[Magie]</div></td></tr>
			<tr>
				<td>Eveillé</td>
				<td colspan="3"><strong>
					<xsl:choose>
						<xsl:when test="qualities/quality[name='Adept']">Adepte</xsl:when>
						<xsl:when test="qualities/quality[name='Mystic Adept']">Adepte Mystique</xsl:when>
						<xsl:when test="qualities/quality[name='Magician']">Magicien</xsl:when>
						<xsl:when test="qualities/quality[name='Aspected Magician']">Magicien Spécialisé</xsl:when>
						<xsl:otherwise>[Ne devrait pas être ici]</xsl:otherwise>
					</xsl:choose>
				</strong></td>
			</tr>
			<xsl:if test="tradition/name != ''">
				<tr>
					<td>Tradition</td>
					<td colspan="3">
						<strong><xsl:value-of select="tradition/name" /> <span style="color:grey;"> (<xsl:value-of select="tradition/spiritform" />)</span></strong>
						<span style="color:grey;">
							<xsl:text> </xsl:text><xsl:value-of select="tradition/source" />
							<xsl:text> </xsl:text><xsl:value-of select="tradition/page" />
						</span>
					</td>
				</tr>
				<tr>
					<td>Combat</td><td><strong><xsl:value-of select="tradition/spiritcombat" /></strong></td>
					<td>Détection</td><td><strong><xsl:value-of select="tradition/spiritdetection" /></strong></td>
				</tr>
				<tr>
					<td>Santé</td><td><strong><xsl:value-of select="tradition/spirithealth" /></strong></td>
					<td>Illusion</td><td><strong><xsl:value-of select="tradition/spiritillusion" /></strong></td>
				</tr>
				<tr>
					<td>Manipulation</td><td><strong><xsl:value-of select="tradition/spiritmanipulation" /></strong></td>
					<td>Drain</td>
					<td>
						<strong>
						<xsl:choose>
							<xsl:when test="qualities/quality[name='Adept']">CON + VOL (<xsl:value-of select="attributes/attribute[name='BOD']/total +attributes/attribute[name='WIL']/total"/>)</xsl:when>
							<xsl:otherwise><xsl:value-of select="tradition/drain" /></xsl:otherwise>
						</xsl:choose>
						</strong>
					</td>
				</tr>
			</xsl:if>
		</table>
	</xsl:template>
	
	<xsl:template name="print_spells">
		<xsl:variable name="sorted_spells">
			<xsl:for-each select="spells/spell">
				<xsl:sort select="category" />
				<xsl:sort select="name" />
				
				<xsl:copy-of select="current()" />
			</xsl:for-each>
		</xsl:variable>
		
		<xsl:if test="count(msxsl:node-set($sorted_spells)/*) &gt; 0">
		
			<table class="stats magic">
				<tr><td colspan="7"><div class="bigheader">[Sorts]</div></td></tr>
				<tr class="smallheader"><td>Sort</td><td>Type</td><td>Portée</td><td>Durée</td><td>Dég</td><td>Drain</td><td>Notes</td></tr>
				<xsl:for-each select="msxsl:node-set($sorted_spells)/spell">
					
					<xsl:if test="category != preceding-sibling::spell[1]/category or position()=1">
						<tr><td colspan="7"><strong><xsl:value-of select="category" /> Sorts</strong></td></tr>
					</xsl:if>
					
					<tr>
						<td>
							<xsl:value-of select="name" />
							<xsl:if test="extra!=''"> (<xsl:value-of select="extra" />)</xsl:if>
							<xsl:call-template name="print_source_page" />
							<xsl:call-template name="print_notes" />
						</td>
						<td><xsl:value-of select="type" /></td>
						<td><xsl:value-of select="range" /></td>
						<td><xsl:value-of select="duration" /></td>
						<td><xsl:value-of select="damage" /></td>
						<td><xsl:value-of select="dv" /></td>
						<td><xsl:value-of select="descriptors" /></td>
					</tr>
				</xsl:for-each>
			</table>
			
		</xsl:if>
	</xsl:template>	
	
	<xsl:template name="print_spirits">
		<xsl:if test="count(spirits/spirit) &gt; 0">
		
			<table class="stats magic">
				<tr><td colspan="2"><div class="bigheader">[Esprits]</div></td></tr>
				<xsl:for-each select="spirits/spirit">
					<xsl:sort select="name" />
					<xsl:sort select="crittername" />
				
					<tr>
						<td>
							<xsl:value-of select="name" />
							<xsl:if test="crittername!=''"> (<xsl:value-of select="crittername" />)</xsl:if>
							<xsl:choose>
								<xsl:when test="bound"> (Lié)</xsl:when>
								<xsl:otherwise> (Non Lié)</xsl:otherwise>
							</xsl:choose>
							<xsl:call-template name="print_source_page" />
							<xsl:call-template name="print_notes" />
							<br />
							<table>
								<tr class="smallheader"><td>Compétence</td><td>Réserve</td></tr>
								<xsl:for-each select="skills/skill">
									<tr>
										<td>
											<xsl:value-of select="name" />
											<span style="color:grey; text-transform: uppercase;"><xsl:text> </xsl:text><xsl:value-of select="attr" /></span>
										</td>
										<td><xsl:value-of select="pool" /></td>
									</tr>
								</xsl:for-each>
							</table>
						</td>
						<td>
							<table style="width:100%;">
								<td>Puissance</td><td><xsl:value-of select="force" /></td><td>Services</td><td><xsl:value-of select="services" /></td>
								<tr><td>Constitution</td><td><xsl:value-of select="spiritattributes/bod" /></td><td>Volonté</td><td><xsl:value-of select="spiritattributes/wil" /></td></tr>
								<tr><td>Agilité</td><td><xsl:value-of select="spiritattributes/agi" /></td><td>Logique</td><td><xsl:value-of select="spiritattributes/log" /></td></tr>
								<tr><td>Réaction</td><td><xsl:value-of select="spiritattributes/rea" /></td><td>Intuition</td><td><xsl:value-of select="spiritattributes/int" /></td></tr>
								<tr><td>Force</td><td><xsl:value-of select="spiritattributes/str" /></td><td>Charisme</td><td><xsl:value-of select="spiritattributes/cha" /></td></tr>
								<tr><td>MC Physique</td><td><xsl:value-of select="ceiling(spiritattributes/bod div 2) + 8" /></td><td>MC Etourdissant</td><td><xsl:value-of select="spiritattributes/cha" /></td></tr>
								<tr><td>Initiative</td><td><xsl:value-of select="spiritattributes/ini" /><xsl:text> + 2d6</xsl:text></td></tr>
							</table>
						</td>
					</tr>
					<tr>
						<td>
							<ul style="margin-left:5px;">
								<xsl:if test="count(powers/power) &gt; 0">
									<li><strong>Pouvoirs</strong></li>
									<xsl:for-each select="powers/power">
										<li>
											<xsl:value-of select="name" />
											<xsl:call-template name="print_source_page" />
										</li>
									</xsl:for-each>
								</xsl:if>
							</ul>
						</td>
						<td>
							<ul style="margin-left:5px;">
								<xsl:if test="count(optionalpowers/power) &gt; 0">
									<li><strong>Pouvoirs Optionnels</strong></li>
									<xsl:for-each select="optionalpowers/power">
										<li>
											<xsl:value-of select="name" />
											<xsl:call-template name="print_source_page" />
										</li>
									</xsl:for-each>
								</xsl:if>
								<xsl:if test="count(weaknesses/weakness) &gt; 0">
									<li><strong>Faiblesses</strong></li>
									<xsl:for-each select="weaknesses/weakness">
										<li>
											<xsl:value-of select="." />
										</li>
									</xsl:for-each>
								</xsl:if>
							</ul>
						</td>
					</tr>
					<xsl:if test="position() != last()">
						<tr><td colspan="2"><hr /></td></tr>
					</xsl:if>
				</xsl:for-each>
			</table>
			
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="print_adept_powers">
		<table class="stats magic">
			<tr><td><div class="bigheader">[Pouvoirs Adepte]</div></td></tr>
			<xsl:for-each select="powers/power">
				<xsl:sort select="name" />
			
				<tr><td><xsl:call-template name="print_nested" /></td></tr>
			</xsl:for-each>
		</table>
	</xsl:template>
	
	<xsl:template name="print_foci">
		<xsl:if test="count(gears/gear[category_english='Foci']) &gt; 0">
		
			<table class="stats magic">
				<tr><td><div class="bigheader">[Focus]</div></td></tr>
				<xsl:for-each select="gears/gear[category_english='Foci']">
					<xsl:sort select="name" />
					<tr><td><xsl:call-template name="print_nested" /></td></tr>
				</xsl:for-each>
			</table>
		
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="print_initiation">
		<xsl:if test="initiategrade &gt; 0">
		
			<table class="stats magic">
				<tr><td><div class="bigheader">[Initiation]</div></td></tr>
				<tr><td>
					<strong>Grade Initiation: <xsl:value-of select="initiategrade" /></strong>
					<br />
					<xsl:if test="count(arts/art) &gt; 0">
						<strong>Arts</strong>
						<ul>
							<xsl:for-each select="arts/art">
								<xsl:sort select="name" />
								
								<li>
									<xsl:value-of select="name" />
									<xsl:call-template name="print_source_page" />
									<xsl:call-template name="print_notes" />
								</li>
							</xsl:for-each>
						</ul>
						<br />
					</xsl:if>
					<xsl:if test="count(metamagics/metamagic) &gt; 0">
						<strong>Métamagies</strong>
						<ul>
							<xsl:for-each select="metamagics/metamagic">
								<xsl:sort select="name" />
								
								<li>
									<xsl:value-of select="name" />
									<xsl:call-template name="print_source_page" />
									<xsl:call-template name="print_notes" />
								</li>
							</xsl:for-each>
						</ul>
					</xsl:if>
				</td></tr>
			</table>
			
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="print_other_gear">
		<xsl:variable name="other_gears">
			<xsl:for-each select="gears/gear[category_english!='ID/Credsticks' and category_english!='Ammunition' and category_english!='Foci' and category_english!='Commlinks' and category_english!='Commlink' and category_english!='Cyberdecks' and category_english!='Rigger Command Consoles']">
				<xsl:sort select="location" />
				<xsl:sort select="name" />
			
				<xsl:copy-of select="current()"/>
			</xsl:for-each>
		</xsl:variable>
	
		<table class="stats gear">
			<tr><td colspan="2"><div class="bigheader">[Equipement]</div></td></tr>
			<tr>
				<td style="width:50%;">
					<xsl:call-template name="print_half_gear">
						<xsl:with-param name="gear_list" select="$other_gears" />
						<xsl:with-param name="condition" select="true()" />
					</xsl:call-template>
				</td>
				<td style="width:50%;">
					<xsl:call-template name="print_half_gear">
						<xsl:with-param name="gear_list" select="$other_gears" />
						<xsl:with-param name="condition" select="false()" />
					</xsl:call-template>
				</td>
			</tr>
		</table>
	</xsl:template>	
	
	<xsl:template name="print_half_gear">
		<xsl:param name="gear_list" />
		<xsl:param name="condition" />
	
		<xsl:variable name="gears_half_count" select="ceiling(count(msxsl:node-set($gear_list)/gear) div 2) + 1" />
		<xsl:variable name="need_location" select="count(msxsl:node-set($gear_list)/gear[location!='']) &gt; 0" />
		<xsl:variable name="need_equip_mark" select="count(msxsl:node-set($gear_list)/gear[equipped='False']) &gt; 0" />
	
		<ul style="margin-left:0px;">
			<xsl:for-each select="msxsl:node-set($gear_list)/gear">
				<xsl:if test="(position() &lt; $gears_half_count)=$condition">
					<xsl:if test="$need_location and (position()=1 or location!=preceding-sibling::gear[1]/location)">
						<li>
							<xsl:call-template name="print_location" />
						</li>
					</xsl:if>
					
					<li>
						<xsl:call-template name="print_nested">
							<xsl:with-param name="need_equip_mark" select="$need_equip_mark" />
						</xsl:call-template>
					</li>
				</xsl:if>
			</xsl:for-each>
		</ul>
	</xsl:template>
	
	<xsl:template name="print_ids">
		<table class="stats gear">
			<tr><td><div class="bigheader">[SIN/Créditubes]</div></td></tr>
			<xsl:for-each select="gears/gear[category_english = 'ID/Credsticks']">
				<xsl:sort select="contains(name_english, 'SIN') or contains(name_english, 'License')" order="descending" />
				<xsl:sort select="name" />
				<tr><td><xsl:call-template name="print_nested" /></td></tr>
			</xsl:for-each>
		</table>
	</xsl:template>
	
	<xsl:template name="print_lifestyle">
		<table class="stats gear">
			<tr><td><div class="bigheader">[Style de Vie]</div></td></tr>
			<xsl:for-each select="lifestyles/lifestyle">
				<xsl:sort select="name" />
				<tr>
					<td>
						<strong>
							<xsl:value-of select="name" />
							<xsl:if test="baselifestyle != ''"> (<xsl:value-of select="baselifestyle" />)</xsl:if>
							<xsl:if test="lifestylename != ''"> (<xsl:value-of select="lifestylename" />)</xsl:if>
						</strong>
						<xsl:call-template name="print_source_page" />
						<xsl:call-template name="print_notes" />
						<br />
            <xsl:choose>
              <xsl:when test="purchased='True'">
                [Permanent]
              </xsl:when>
              <xsl:otherwise>
                Coût: <xsl:value-of select="cost" />&#165; (<xsl:value-of select="totalmonthlycost" />&#165;) x<xsl:value-of select="months" /> = <xsl:value-of select="totalcost" />&#165;
              </xsl:otherwise>
            </xsl:choose>
            <br />
						<ul>
						<xsl:for-each select="qualities/lifestylequality">
							<li>
								<xsl:value-of select="current()" />
							</li>
						</xsl:for-each>
						</ul>
					</td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>
	
	<xsl:template name="print_description">
		<xsl:if test="description!=''">
			<table class="stats description">
				<tr><td><div class="bigheader">[Description]</div></td></tr>
				<tr><td>
					<xsl:call-template name="PreserveLineBreaks">
						<xsl:with-param name="text" select="description" />
					</xsl:call-template>
				</td></tr>
			</table>
			<br />
		</xsl:if>
		<xsl:if test="background!=''">
			<table class="stats description">
				<tr><td><div class="bigheader">[Background]</div></td></tr>
				<tr><td>
					<xsl:call-template name="PreserveLineBreaks">
						<xsl:with-param name="text" select="background" />
					</xsl:call-template>
				</td></tr>
			</table>
			<br />
		</xsl:if>
		<xsl:if test="concept!=''">
			<table class="stats description">
				<tr><td><div class="bigheader">[Concept]</div></td></tr>
				<tr><td>
					<xsl:call-template name="PreserveLineBreaks">
						<xsl:with-param name="text" select="concept" />
					</xsl:call-template>
				</td></tr>
			</table>
			<br />
		</xsl:if>
    <xsl:if test="hasothermugshots = 'yes'">
      <table class="stats description">
        <tr>
          <td>
            <div class="bigheader">[Autres Portraits]</div>
          </td>
        </tr>
        <tr>
          <td>
            <table width="100%" cellspacing="0" cellpadding="0" border="0" style="empty-cells:show;">
              <tr>
                <td width="33%" style="text-align:center;">
                  <table width="100%" cellspacing="0" cellpadding="0" border="0" style="empty-cells:show;">
                    <xsl:for-each select="othermugshots/mugshot[position() mod 3 = 1]">
                      <tr>
                        <td width="100%" style="text-align:center;">
                          <img>
                            <xsl:attribute name="src">
                              data:image/png;base64,<xsl:value-of select='stringbase64' />
                            </xsl:attribute>
                          </img>
                        </td>
                      </tr>
                    </xsl:for-each>
                  </table>
                </td>
                <td width="33%" style="text-align:center;">
                  <table width="100%" cellspacing="0" cellpadding="0" border="0" style="empty-cells:show;">
                    <xsl:if test="count(othermugshots/mugshot[position() mod 3 = 2]) = 0">
                      <tr>
                        <td></td>
                      </tr>
                    </xsl:if>
                    <xsl:for-each select="othermugshots/mugshot[position() mod 3 = 2]">
                      <tr>
                        <td width="100%" style="text-align:center;">
                          <img>
                            <xsl:attribute name="src">
                              data:image/png;base64,<xsl:value-of select='stringbase64' />
                            </xsl:attribute>
                          </img>
                        </td>
                      </tr>
                    </xsl:for-each>
                  </table>
                </td>
                <td width="33%" style="text-align:center;">
                  <table width="100%" cellspacing="0" cellpadding="0" border="0" style="empty-cells:show;">
                    <xsl:if test="count(othermugshots/mugshot[position() mod 3 = 0]) = 0">
                      <tr>
                        <td></td>
                      </tr>
                    </xsl:if>
                    <xsl:for-each select="othermugshots/mugshot[position() mod 3 = 0]">
                      <tr>
                        <td width="100%" style="text-align:center;">
                          <img>
                            <xsl:attribute name="src">
                              data:image/png;base64,<xsl:value-of select='stringbase64' />
                            </xsl:attribute>
                          </img>
                        </td>
                      </tr>
                    </xsl:for-each>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <br />
    </xsl:if>
		
		<xsl:if test="notes!='' or gamenotes!=''">
			<table class="stats description">
				<tr><td><div class="bigheader">[Notes]</div></td></tr>
				<tr><td>
					<xsl:call-template name="PreserveLineBreaks">
						<xsl:with-param name="text" select="notes" />
					</xsl:call-template>
				</td></tr>
				<xsl:if test="notes!='' and gamenotes!=''">
					<tr><td><hr /></td></tr>
				</xsl:if>
				<tr><td>
					<xsl:call-template name="PreserveLineBreaks">
						<xsl:with-param name="text" select="gamenotes" />
					</xsl:call-template>
				</td></tr>
			</table>
			<br />
		</xsl:if>
		
		<xsl:if test="count(calendar/week) &gt; 0">
			<table class="stats description">
				<tr><td colspan="2"><div class="bigheader">[Calendrier]</div></td></tr>
				<tr class="smallheader"><td>Date</td><td>Notes</td></tr>
				<xsl:for-each select="calendar/week">
					<tr>
						<td style="white-space:pre;">
							<strong>
								<xsl:value-of select="year" /><xsl:text>, </xsl:text>
								<xsl:text>Mois </xsl:text><xsl:value-of select="month" /><xsl:text>, </xsl:text>
								<xsl:text>Semaine </xsl:text><xsl:value-of select="week" /><xsl:text> </xsl:text>
							</strong>
						</td>
						<td style="width:100%;">
							<xsl:call-template name="PreserveLineBreaks">
								<xsl:with-param name="text" select="notes" />
							</xsl:call-template>
						</td>
					</tr>
				</xsl:for-each>
			</table>
			<br />
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="print_nested">
		<xsl:param name="need_equip_mark" select="false()" />
		
		<xsl:variable name="is_long_extra" select="name_english='Custom Fit (Stack)'" />
	
		<span>
			<xsl:if test="included and included='True'">
				<xsl:attribute name="style">color:grey;</xsl:attribute>
			</xsl:if>
			<xsl:if test="$need_equip_mark">
				<xsl:choose>
					<xsl:when test="equipped='True'">&#x26AB; </xsl:when>
					<xsl:otherwise>&#x26AA; </xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<xsl:value-of select="name" />
			<xsl:if test="extra!='' and not($is_long_extra)">
				(<xsl:value-of select="extra" />)
			</xsl:if>
			<xsl:if test="rating &gt; 0">
				<xsl:text> [R</xsl:text><xsl:value-of select="rating" />]
			</xsl:if>
			<xsl:if test="qty and qty &gt; 1">
				<xsl:text> x</xsl:text><xsl:value-of select="qty" />
			</xsl:if>
			<xsl:call-template name="print_source_page" />
			<xsl:if test="extra!='' and $is_long_extra">
				<br />
				(<xsl:value-of select="extra" />)
			</xsl:if>
			<xsl:call-template name="print_notes" />
		</span>
		
		<xsl:if test="count(children/gear) &gt; 0">
			<xsl:variable name="child_need_equip_mark" select="count(children/gear[equipped='False']) &gt; 0" />
			<ul>
				<xsl:for-each select="children/gear">
					<xsl:sort select="name" />
				
					<li>
						<xsl:call-template name="print_nested">
							<xsl:with-param name="need_equip_mark" select="$child_need_equip_mark" />
						</xsl:call-template>
					</li>
				</xsl:for-each>
			</ul>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="print_source_page">
		<span style="color:grey;">
			<xsl:text> </xsl:text><xsl:value-of select="source" /><xsl:text> </xsl:text><xsl:value-of select="page" />
		</span>
	</xsl:template>
	
	<xsl:template name="print_notes">
		<xsl:param name="linebreak" select="true()" />
	
		<xsl:if test="notes!=''">
			<xsl:if test="$linebreak">
				<br />
			</xsl:if>
			<span style="color:darkgreen;">
				<sup><i>
						<xsl:call-template name="PreserveLineBreaks">
							<xsl:with-param name="text" select="notes"/>
						</xsl:call-template></i></sup>
			</span>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="print_location">
		<strong>
			<xsl:choose>
				<xsl:when test="location=''">Equipement Sélectionné</xsl:when>
				<xsl:otherwise><xsl:value-of select="location" /></xsl:otherwise>
			</xsl:choose>
		</strong>
	</xsl:template>
	
	<xsl:template name="make_grey_lines">
		<xsl:if test="(position() mod 2) = 0">
			<xsl:attribute name="style">
				background-color:lightgrey;
			</xsl:attribute>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="page_breaker">
		<tr class="page_breaker_off" onClick="toggle_page_breaker(this);">
			<td colspan="3">
				Saut de Page: <span class="page_breaker_status">OFF</span>
			</td>
		</tr>
	</xsl:template>
	
</xsl:stylesheet>
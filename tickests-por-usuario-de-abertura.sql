SELECT
/*usuario_abertura.*/
     
glpi_tickets.id, glpi_tickets.name as titulo, glpi_tickets.date, glpi_tickets.closedate, glpi_tickets.solvedate, glpi_tickets.date_mod, 
glpi_tickets.users_id_lastupdater, glpi_tickets.status, glpi_tickets.users_id_recipient, glpi_tickets.content,
glpi_tickets.urgency, glpi_tickets.impact, priority, glpi_tickets.itilcategories_id, glpi_tickets.type, glpi_tickets.slas_id_ttr, 
glpi_tickets.slas_id_tto, glpi_tickets.slalevels_id_ttr, glpi_tickets.time_to_resolve, glpi_tickets.locations_id,     
glpi_locations.completename AS setor_abertura, glpi_locations.name AS setor_abertura_global,
CONCAT_WS(' ', usuario_abertura.firstname, usuario_abertura.realname) AS usuario_abertura,
glpi_itilcategories.completename as categoria,
glpi_groups.completename as Setor_chamado,
CONCAT_WS(' ',tecnico.firstname, tecnico.realname) AS tecnico,
glpi_itilsolutions.status AS status_solucao

FROM glpi_tickets LEFT JOIN glpi_users AS usuario_abertura
ON glpi_tickets.users_id_recipient = usuario_abertura.id
LEFT JOIN glpi_locations 
ON usuario_abertura.locations_id = glpi_locations.id  
LEFT JOIN glpi_itilcategories 
ON glpi_tickets.itilcategories_id = glpi_itilcategories.id
LEFT join glpi_groups_tickets ON
glpi_tickets.id = glpi_groups_tickets.tickets_id 
left JOIN glpi_groups 
on glpi_groups_tickets.groups_id = glpi_groups.id
left join glpi_itilsolutions 
on glpi_tickets.id = glpi_itilsolutions.items_id
AND glpi_itilsolutions.status in(1,2,3) 
AND glpi_itilsolutions.itemtype = 'ticket' 
left join glpi_users as tecnico 
on glpi_itilsolutions.users_id = tecnico.id 
where glpi_tickets.is_deleted = 0
and year(glpi_tickets.date) >= 2019
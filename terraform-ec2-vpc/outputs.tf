# EC2 Server Names
output "server1_name" { value = aws_instance.server1.tags["Name"] }
output "server2_name" { value = aws_instance.server2.tags["Name"] }
output "server3_name" { value = aws_instance.server3.tags["Name"] }
output "server4_name" { value = aws_instance.server4.tags["Name"] }

# Public IPs
output "server1_public_ip" { value = aws_instance.server1.public_ip }
output "server2_public_ip" { value = aws_instance.server2.public_ip }
output "server3_public_ip" { value = aws_instance.server3.public_ip }
output "server4_public_ip" { value = aws_instance.server4.public_ip }


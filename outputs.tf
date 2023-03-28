output "vpc_id"{
  value = aws_vpc.sabin.id
}

output "public_subnet"{
  value = aws_subnet.sabin-public.id
}

output "private_subnet"{
  value = aws_subnet.sabin-private.id
}
# Terraform-vpc-project

This project demonstrates the creation of a **secure two-tier AWS architecture** using **Terraform (Infrastructure as Code)**.
It provisions a custom VPC with public and private subnets, Internet Gateway, NAT Gateway, route tables, and EC2 instances for frontend and backend layers.

The architecture ensures:

* Public access only to frontend server
* Private backend server isolated from the internet
* Controlled internal communication between tiers

---

##  Architecture Design

* **VPC**: Custom Virtual Private Cloud
* **Public Subnet**: Hosts frontend EC2 (Apache web server)
* **Private Subnet**: Hosts backend EC2 (application server)
* **Internet Gateway**: Enables internet access for public subnet
* **NAT Gateway**: Allows private subnet outbound internet access
* **Security Groups**: Controls inbound/outbound traffic between tiers

---

##  Technologies Used

* Terraform (Infrastructure as Code)
* AWS (EC2, VPC, Subnets, IGW, NAT Gateway, Security Groups)
* Amazon Linux 2023
* Apache HTTP Server (Frontend)
* Shell scripting (User Data)

---

##  Repository Structure

```
terraform-vpc-project/
│
├── provider.tf
├── vpc.tf
├── subnets.tf
├── igw.tf
├── nat.tf
├── routes_tables.tf
├── security_groups.tf
├── ec2.tf
├── variables.tf
├── outputs.tf
└── README.md
```

---

##  Deployment Steps

### 1. Initialize Terraform

```bash
terraform init
```

---

### 2. Validate Configuration

```bash
terraform validate
```

---

### 3. Plan Infrastructure

```bash
terraform plan
```

---

### 4. Deploy Resources

```bash
terraform apply -auto-approve
```

---

##  Access Details

### Frontend Server

* Runs Apache HTTP Server
* Accessible via Public IP

```bash
http://<frontend-public-ip>
```

Expected Output:

```
Frontend Server
```

---

### Backend Server

* Runs inside private subnet
* No public IP assigned

Tested via frontend EC2:

```bash
curl http://<backend-private-ip>
```

Expected Output:

```
Backend Server Running
```

---

##  Security Implementation

* Frontend:

  * Allows HTTP (80) from internet
  * Allows SSH (22)

* Backend:

  * Allows access only from frontend security group
  * No direct internet exposure

---

##  Connectivity Verification

✔ Frontend → Backend communication tested via private IP
✔ NAT Gateway verified using `yum update` from backend
✔ Backend is not publicly accessible
✔ SSH access controlled via key-based authentication

---

##  Key Features Achieved

* Infrastructure as Code using Terraform
* Secure VPC design with public/private segmentation
* NAT Gateway for private subnet internet access
* Controlled security group-based communication
* Fully automated EC2 provisioning using user data scripts

---

##  Testing Performed

* HTTP access to frontend server
* Backend connectivity via private IP
* NAT Gateway validation via package updates
* SSH access between instances (bastion-style flow)

---

